--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_fields_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_fields_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_fields_list;
--
insert into public.z01_ds_fields_list
with
t_ds_fields as (
  select 
    trim(both '"' from f.entity_key) as dsm_id  
    ,replace(entity_value,trim(both '"' from f.entity_key)||'_','') as json_txt
  from public.finebi_d_entryfield_en f 
  where f.value_class = 'EntryFieldPO' 
	union all
	  select 
    trim(both '"' from f.entity_key) as dsm_id  
    ,replace(entity_value,trim(both '"' from f.entity_key)||'_','') as json_txt
  from public.finebi_s_entryfield_en f 
  where f.value_class = 'EntryFieldPO' 
),
t_pre as (
  select 
    dsm_id
    ,trim(both '"' from (ds_fields -> 'id')::text) as dsm_field_id
    ,trim(both '"' from (ds_fields -> 'name')::text) as dsm_field_name
    ,trim(both '"' from (ds_fields -> 'type')::text) as dsm_field_type
    ,trim(both '"' from (ds_fields -> 'fieldGroupType')::text) as dsm_field_fieldGroupType
    ,trim(both '"' from (ds_fields -> 'usable')::text) as dsm_field_usable
    ,trim(both '"' from (ds_fields -> 'dataFieldName')::text) as dsm_field_dataFieldName
    ,trim(both '"' from (ds_fields -> 'dataType')::text) as dsm_field_dataType
    ,trim(both '"' from (ds_fields -> 'dataRowFieldMeta')::text) as dsm_field_dataRowFieldMeta
    ,trim(both '"' from (ds_fields -> 'dataRowFieldMeta' -> 'jdbcType')::text) as dsm_field_jdbcType
    ,trim(both '"' from (ds_fields -> 'dataRowFieldMeta' -> 'columnSize')::text) as dsm_field_columnSize
    ,trim(both '"' from (ds_fields -> 'dataRowFieldMeta' -> 'columnScale')::text) as dsm_field_columnScale
    ,row_number() over (partition by dsm_id) as dsm_pos_in_table
  from t_ds_fields t
  cross join lateral jsonb_array_elements(json_txt::jsonb -> 'fields') as ds_fields
)
select 
	 p.dsm_id
	,p.dsm_pos_in_table
	,p.dsm_field_id
	,p.dsm_field_name
	,p.dsm_field_datafieldname as dsm_field_name_src
	,case when p.dsm_field_name = p.dsm_field_datafieldname then 0 else 1 end as dsm_field_is_rename 
	,p.dsm_field_type
	,p.dsm_field_datatype as dsm_field_type_src
	,case when p.dsm_field_type = p.dsm_field_datatype then 0 else 1 end as dsm_field_is_convert
	,p.dsm_field_fieldgrouptype
	,p.dsm_field_usable as dsm_field_usable 
	,p.dsm_field_datarowfieldmeta
	,p.dsm_field_jdbctype
	,p.dsm_field_columnsize
	,p.dsm_field_columnscale
from t_pre p
order by dsm_id, dsm_pos_in_table;
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
