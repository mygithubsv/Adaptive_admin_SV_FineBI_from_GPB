--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_ec2tableid()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_ec2tableid';
begin
begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_ec2tableid; 
insert into public.z01_ds_ec2tableid 
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
)
select distinct
  trim(both '"' from (se.entity_value::jsonb -> 'id')::text) as dsm_table_id -- уникальный table_id сущности
  ,trim(both '"' from (se.entity_value::jsonb -> 'name')::text) as dsm_table_name --уникальный текстовый table_name сущности
  ,coalesce(tt.table_name,t.table_id_s) as dsd_table_name -- НЕуникальный текстовый table_name сущности
  ,trim(both '"' from (se.entity_value::jsonb -> 'driverType')::text) as dsm_driver_type
from (
  select * from public.finebi_s_entrycreate_en
    union all
  select * from public.finebi_d_entrycreate_en
) se 
left join t_name_map t on trim(both '"' from se.entity_key)=t.table_id 
left join t_trans_tab tt on trim(both '"' from se.entity_key)=tt.table_id
where se.value_class = 'EntryCreatePO';
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
COMMENT ON FUNCTION public.zfr_ds_ec2tableid() IS 'ds origin #1.1';
--
