--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_con_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_con_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_con_list;
insert into public.z01_con_list
with
tb as (
  select
    replace(fe.id,'ConnectionConfig.connections.','') as val
    ,fe.value --select *
  from public.fine_conf_entity fe
  where id like 'ConnectionConfig.connections.%'
),
t_buf as (
  select
    substring(tb.val from 1 for position('.' in tb.val)-1) as Name
    ,substring(tb.val from 1+position('.' in tb.val) for 100) as par
    ,tb.val as ful_par
    ,case when
      tb.value like '%postgresql%'
      or tb.value like '%mysql%'
      or tb.value like '%vertica%'
      or tb.value like '%clickhouse%'
      or tb.value like '%sybase%'
      or tb.value like '%oracle%'
    then replace(replace(replace(replace(replace(value,'//','|'),'/',' = '),' = ','; = '),' ',''),' ','') 
    else replace(replace(value,'//','|'),' ','') 
    end as value
    ,tb.value as value_orig
  from tb
),
t_pre as (
  select
    name
    ,max(case when par = 'creator' then value else null end) as con_creator
    ,max(case when par = 'database' then value else null end) as con_database_type
    ,max(case when par = 'url' then substring(value from position(':|' in value)+2
        for case when position(';' in value)>position(':|' in value) then position(';' in value) - position(':|' in value)-2 else 0 end
      ) else null end) as con_host
    ,max(case
    when par = 'url'
      then substring(value from position(' = ' in value)+1)
    else null
    end) as con_db
    ,max(case when par = 'authentication.username' then value else null end) as con_username
    ,max(case when par = 'url' then value_orig else null end) as con_url
    --  
    ,max(case when ful_par like '%.ssh.ip'             then value_orig else null end) as ssh_ip
    ,max(case when ful_par like '%.ssh.port'           then value_orig else null end) as ssh_port
    ,max(case when ful_par like '%.ssh.secret'         then 1 else 0 end) as ssh_secret
    ,max(case when ful_par like '%.ssh.user'           then value_orig else null end) as ssh_user
    ,max(case when ful_par like '%.ssh.usingSsh'       then value_orig else null end) as is_ssh
    ,max(case when ful_par like '%.ssh.privateKeyPath' then value_orig else null end) as ssh_key
  --
  from t_buf f
  group by name
  order by con_host, con_database_type, con_creator 
),
t_list_con as (
  -- список подключений
  select distinct replace(replace(id, 'ConnectionConfig.connections.',''),'.url','') as con_name
  from public.fine_conf_entity f
  where id like 'ConnectionConfig.connections.%.url'
),
t_lost_conn as (
	-- потерянные соединения (уведомления администратору за 3 дня)
	select distinct
		c.con_name as lost_con_name
		,max(b.createTime) as dat
		,(now() - max(b.createTime)) as intrvl
		,count(b.id) as cnt_conn
	from public.fine_base_message b
	left join t_list_con c on 1 = 1
	where url = '#plugin/management/connection'
		and b.createTime > now()::date - 3 * interval '1 day'
		and username = 'admin'
		and b.message like concat('%',c.con_name,'%')
		and b.message like '%Data connection failed%'
	group by c.con_name
	order by 1, 2
)
select
  Name as cm_con_name_ui
  ,con_creator as cm_con_creator_id
  ,fu.realName as cm_con_creator_name
  ,con_database_type as cm_con_database_type
  ,case 
    when con_database_type = 'sap-sybase'
			then split_part(con_url,':',4)
    when con_url in ('jdbc:swift:emb://default') 
			or lower(con_url) like 'jdbc:%env_home%'
    	then 'FineBI'
    when con_url like 'jdbc:oracle%' 
			then split_part(split_part(con_url,'@',2),':',1)
    when con_url like 'https:%' 
			then 
			replace(
				split_part(con_url,'/',3)
			,'you_site.ru','')
    else 
			replace(
				lower(case when position(':' in con_host)>0 then substring(con_host from 1 for position(':' in con_host)-1) else con_host end)
				,'you_site.ru','')
    end 
    as cd_con_host
  ,case 
	  	when con_database_type = 'sap-sybase' then split_part(split_part(con_db,':',-1),';',1) 
	  	when con_db like 'https:%' then 'HTTPS'
	  	when position(':' in con_host)>0 then split_part(substring(con_host from position(':' in con_host)+1),'/',1)
    else
			case
				when con_database_type = 'postgresql' then '5432'
				when con_database_type = 'mysql' then '3306'
				when con_database_type = 'sql-server' then '1433'
				when con_database_type = 'clickhouse' then '8123'
				else null
				end
  end as cd_con_port
  ,case 
	  	when con_db like 'jdbc:vertica%'
		  	or con_db like 'jdbc:postgresql%'
		  	or con_db like 'jdbc:sybase%'
		  	or con_db like 'jdbc:sqlserver%'
		  	or con_db like 'jdbc:clickhouse%'
		  	then split_part(con_db,'=',2) 
	  	when con_db like 'jdbc:oracle%'
		  	then split_part(con_db,':',-1) 
	  	when con_db like 'jdbc:impala%'
	  		then split_part(split_part(con_db,'/',2),';',1) 
	  	when con_db like 'https:%'
	  		then split_part(con_db,'/',2)
  	else con_db end 
  	as cm_con_db
  ,con_username as cm_con_login
  ,lower(con_url) as cm_con_url
  ,t.lost_con_name as cd_lost_con_name
  ,t.dat as cd_lost_con_dtime
  ,extract(hour from t.intrvl) as cd_lost_con_intrvl_hour_int
  ,extract(hour from t.intrvl)||':'||extract(minute from t.intrvl) as cd_lost_con_intrvl_txt
  ,t.cnt_conn as cd_cnt_lost_conn_3day
  --
  ,case when p.ssh_ip not in ('hostname','__EMPTY__') then p.ssh_ip else null end as cm_ssh_ip
  ,case when p.ssh_ip not in ('hostname','__EMPTY__') then p.ssh_port else null end as cm_ssh_port
  ,case when p.ssh_ip not in ('hostname','__EMPTY__') then p.ssh_user else null end as cm_ssh_user
  ,case when p.ssh_ip not in ('hostname','__EMPTY__') then split_part(p.ssh_key,'/',3) else null end as cm_ssh_key   
from t_pre p
left join public.fine_user fu on fu.userAlias = con_creator
left join t_lost_conn t on p.Name = t.lost_con_name
order by con_database_type, con_host;
--#CODE OPERATION
is_corr = true;
--
raise info '2. % finish with state: %', proc_name, is_corr;
call public.zfr_proc_log(proc_name,1,ses_id);
return is_corr;
	exception
			when others then
			call public.zfr_proc_log(proc_name,0,ses_id,'code:'||sqlstate||'. '||left(sqlerrm,100));
			raise info '!!! ERROR: %', sqlerrm;
			return false;
	end;
end;
$function$
;
--
