--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_list;
--
insert into public.z01_ds_list
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
t_ec as (
  select entity_key, entity_value::jsonb as content 
  from public.finebi_s_entrycreate_en f 
  where value_class  = 'EntryCreatePO'
    union all 
  select entity_key, entity_value::jsonb as content 
  from public.finebi_d_entrycreate_en f 
  where value_class  = 'EntryCreatePO'
),
t_tab as (
select 
  trim(both '\"' from entity_key) as dsm_id
  ,coalesce(tt.table_name,t.table_id_s) as dsm_name
  ,to_timestamp(trim(both '\"' from (content -> 'configCreatedTime')::text)::bigint/1000)::timestamp as dsm_config_created
  ,trim(both '\"' from (content -> 'driverType')::text) as dsm_driver_type
  ,trim(both '\"' from (content -> 'dbTableName')::text) as dsm_db_name
  ,trim(both '\"' from (content -> 'connectionName')::text) as dsm_con_name
  ,trim(both '\"' from (content -> 'creator')::text) as dsm_creator_id
  ,fu.username as dsm_creator_name
from t_ec e
left join public.fine_user fu on (content -> 'creator')::text = '"'||fu.id||'"' 
left join t_name_map t on trim(both '\"' from entity_key)=t.table_id 
left join t_trans_tab tt on trim(both '\"' from entity_key)=tt.table_id
)
select * from t_tab;
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
COMMENT ON FUNCTION public.zfr_ds_list() IS 'ds origin #1.2';
--
