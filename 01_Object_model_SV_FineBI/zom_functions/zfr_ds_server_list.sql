--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_server_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_server_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_server_list;
--
insert into public.z01_ds_server_list
with
tb as (
  select
    split_part(fe.id,'.',3) as name
    ,fe.id
    ,fe.value
  from public.fine_conf_entity fe
  where id like 'TableDataConfig.tableDatas.%' and id not like '%.columns.%'
),
t_buf as (
  select
		 tb.name
    ,tb.value
    ,tb.id
  from tb
),
t_pre as (
  select
    name
    ,max(case when id like '%.database.name' then value else null end) as dss_con_name
    ,max(case when id like '%.connectionName' then value else null end) as dss_ssas_con_name
    ,max(case when id like '%.query' then value else null end) as dss_con_query
    ,max(case when id like '%.dataSource.filePath' then value else null end) as dss_path_ds
    ,max(case when id like '%.filePath' then value else null end) as dss_path
    ,max(case when id like '%.packageName' then value else null end) as dss_package_name
    ,max(case when id like '%.cube' then value else null end) as dss_ssas_cube
    ,max(case when id like '%.dsName' then value else null end) as dss_dsName
  from t_buf f
  group by name
  order by 1 
)
select 
name
,case 
	when dss_ssas_cube is not null then 'SSAS'
	when dss_con_query is not null then 'SQL'
	when dss_dsName is not null then 'SQL'
	when dss_path_ds is not null then 'XML'
	when dss_path is not null then 'TEXT'
	else 'SPFR'
end
as dss_type
,coalesce(dss_con_name,dss_ssas_con_name,dss_package_name) as dss_con_name
,coalesce(dss_con_query,dss_path_ds,dss_path,dss_ssas_cube) as dss_obj 
from t_pre
order by 2,1;
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
