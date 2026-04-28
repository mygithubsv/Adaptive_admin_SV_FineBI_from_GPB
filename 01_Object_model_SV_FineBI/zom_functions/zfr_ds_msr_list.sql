--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_msr_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_msr_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_msr_list;
insert into public.z01_ds_msr_list
with
t_msr_upd as (
	select 
	  trim(both '"' from f.entity_key) as dsm_msr_id  
	  ,to_timestamp(entity_value::bigint/100)::timestamp as dsm_msr_updated
	from public.finebi_measure_index_en f 
	where namespace = 'MeasureUpdateTime'
),
t_msr2ds as (
	select 
	  trim(both '"' from f.entity_key) as dsm_msr_id  
	  ,replace((entity_value::jsonb -> 'values')[0]::text,'"','') as dsm_id_uniq
	from public.finebi_measure_index_en f 
	where namespace = 'MeasureTablesMapping'
),
t_ds_fields as (
  select 
    trim(both '"' from f.entity_key) as dsm_msr_id  
    ,entity_value::jsonb as contents
  from public.finebi_measure_index_en f 
  where f.value_class = 'MeasureIndexPO' 
),
t_pre as (
  select 
    dsm_msr_id
    ,trim(both '"' from (contents -> 'name')::text) as dsm_msr_name
    ,trim(both '"' from (contents -> 'createBy')::text) as dsm_msr_creator_id
    ,to_timestamp(trim(both '"' from (contents -> 'createTime')::text)::bigint/1000)::timestamp as dsm_msr_created
    ,trim(both '"' from (contents -> 'type')::text) as dsm_msr_type
    ,trim(both '"' from (contents -> 'measureType')::text) as dsm_msr_measureType
    ,trim(both '"' from (contents -> 'engineType')::text) as dsm_msr_engineType
  from t_ds_fields t
)
select 
	d.dsm_id_uniq
	,p.dsm_msr_id
	,p.dsm_msr_name
	,p.dsm_msr_creator_id
	,p.dsm_msr_created
	,p.dsm_msr_type
	,p.dsm_msr_measuretype
	,p.dsm_msr_enginetype
	,u.dsm_msr_updated
from t_pre p
left join t_msr_upd u on u.dsm_msr_id=p.dsm_msr_id
left join t_msr2ds d on d.dsm_msr_id=p.dsm_msr_id
order by 1,2;
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
