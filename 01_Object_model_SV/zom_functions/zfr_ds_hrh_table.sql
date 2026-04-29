--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_hrh_table()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_hrh_table';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_hrh_table;
--
insert into public.z01_ds_hrh_table
with
t_name_map as (
  select 
    trim(both '"' from f.entity_key) as table_id_s
    ,trim(both '"' from f.entity_value) as table_id
  from public.finebi_idnamemap_en f 
  where "namespace" = 'Name_Id'
),
t_trans_tab as (
  select 
    trim(both '"' from t.entity_key) as table_id
    ,trim(both '"' from t.entity_value) as table_name
  from public.finebi_transname_en t
  where t.namespace = 'TableTransferName'
),
t_list_table_id_from_name_ec as (
select distinct
  trim(both '"' from (se.entity_value::jsonb -> 'id')::text) as table_id_ec
  ,trim(both '"' from (se.entity_value::jsonb -> 'name')::text) as table_name_ec
  ,coalesce(t.table_id,tt.table_id) as table_id_res
  ,coalesce(tt.table_name,t.table_id_s) as table_name_res
from (
  select * from public.finebi_s_entrycreate_en
    union all
  select * from public.finebi_d_entrycreate_en
) se 
left join t_name_map t on trim(both '"' from se.entity_key)=t.table_id 
left join t_trans_tab tt on trim(both '"' from se.entity_key)=tt.table_id
where se.value_class = 'EntryCreatePO'
),
t_pkg as (
	select 
	  replace(j.entity_key,'"','') as entity_key
	  --,content
	  ,replace((j.content -> 'name')::text,'"','') as name
	  ,u.username 
	  ,to_timestamp((j.content -> 'configCreatedTime')::text::bigint/1000)::timestamp as configCreatedTime
  from (select entity_key, entity_value::jsonb as content from public.finebi_package_en p where p.value_class = 'PackageCreatePO') j
  left join public.fine_user u on '"'||u.id||'"'=(j.content -> 'creator')::text  
),
t_pid as (
  select 
    replace(j.entity_key,'"','') as entity_key
    --,content
    ,replace((j.content -> 'pid')::text,'"','') as pid
    ,replace((j.content -> 'subIds')::text,'"','') as subIds
  from (
    select entity_key, entity_value::jsonb as content from public.finebi_package_en p where p.value_class = 'PackageParentPO'
  ) j
),
t_dir as (
  select 
    t2.entity_key
    ,p2.name
    ,t1.entity_key as pid
    , p1.name as pid_name
    , t1.subIds
  from t_pid t1
  left join t_pid t2 on 1=1
  left join t_pkg p1 on p1.entity_key=t1.entity_key
  left join t_pkg p2 on p2.entity_key=t2.entity_key
  where t1.subIds like '%'||t2.entity_key||'%'
),
t_dir_top_level as (
select 
    t1.entity_key
    ,p1.name
    ,null as pid
    , null as pid_name
    , t1.subIds
  from t_pid t1
  left join t_pkg p1 on p1.entity_key=t1.entity_key
  where t1.pid = '' 
),
t_trans_name as (
  --table name translate
  select 
    replace(t.entity_key,'"','') as entity_key 
    ,replace(t.entity_value,'"','') as trans_name
  from public.finebi_transname_en t
  where namespace = 'TableTransferName'
),
t_ext as (
  select 
    replace(t.entity_key,'-','') as dsm_id_child
    ,t.name as dsm_name_child
    ,replace(t.pid,'-','') as dsm_id_parent
    , t.pid_name as dsm_name_parent
    ,replace(replace(s.entity_key,'"',''),'P@@@','') as dsm_entity_key_ds
    ,e.table_name_res as dsd_trans_name
  from (select * from t_dir union all select * from t_dir_top_level) t
  left join (select * from public.finebi_pakcagesubitem_en s where s.namespace = 'TableItem_Package') s on t.entity_key=replace(replace(s.entity_value,'"',''),'P@@@','')
  left join t_list_table_id_from_name_ec e on e.table_id_res=replace(replace(s.entity_key,'"',''),'P@@@','')
) 
select * 
from t_ext;
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
