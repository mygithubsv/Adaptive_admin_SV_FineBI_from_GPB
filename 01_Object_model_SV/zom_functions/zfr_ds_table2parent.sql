--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_table2parent()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_table2parent';
begin
begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_table2parent;
--
insert into public.z01_ds_table2parent
with
t_buf as (
select 
  'S' as engine_type
  ,trim(both '"' from entity_key) as table_id
  ,trim(both '"' from t_tab::text) as parent_table_id
from public.finebi_s_entrysnapshot_en
cross join lateral jsonb_array_elements(entity_value::jsonb -> 'parentTableNames') AS t_tab
where "namespace" = 'entry_parentsnapshot_s'
union all
select 
  'D' as engine_type
  ,trim(both '"' from entity_key) as table_id
  ,trim(both '"' from t_tab::text) as parent_table_id
from public.finebi_d_entrysnapshot_en
cross join lateral jsonb_array_elements(entity_value::jsonb -> 'parentTableNames') AS t_tab
where "namespace" = 'entry_parentsnapshot_d'
)
select 
  b.engine_type as dsm_engine_type
  ,tf.dsm_table_id as dsm_table_id_from
  ,tf.dsd_table_name as dsm_table_name_from
  ,tt.dsm_table_id as dsm_table_id_to
  ,tt.dsd_table_name as dsm_table_name_to
  ,tf.dsm_driver_type as dsm_table_type_from
  ,tt.dsm_driver_type as dsm_table_type_to
from t_buf b
left join public.z01_ds_ec2tableid tt on replace(b.parent_table_id,'P@@@','')=tt.dsm_table_id
left join public.z01_ds_ec2tableid tf on b.table_id=tf.dsm_table_id;
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
COMMENT ON FUNCTION public.zfr_ds_table2parent() IS 'ds origin #2 from z01_ds_ec2tableid';
--
