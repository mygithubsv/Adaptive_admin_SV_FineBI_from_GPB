--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_upd_task_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_alloc_system_resorce_dir4redirect';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_upd_task_list;
--
insert into public.z01_upd_task_list
with
ds_s_ent as (
SELECT 
  (json_val -> 'id')::text as id
  ,t_tab -> 'setting' -> 'frequency' -> 'type' as timeList_frequency_type
  ,(t_tab -> 'setting' -> 'frequency' -> 'value' -> 'unit') as timeList_frequency_value_unit
  ,t_tab -> 'setting' -> 'frequency' -> 'value' -> 'space' as timeList_frequency_value_space
  ,t_tab -> 'cron' as timeList_cron
  ,t_tab -> 'setting' -> 'taskName' as timeList_taskName --???
  ,t_tab as timeList_id
  ,t_tab -> 'id' as timeList_id
  ,t_tab -> 'type' as timeList_type
  ,t_tab -> 'endTime' as timeList_endTime
  ,t_tab -> 'startTime' as timeList_startTime
  ,t_tab as content
from (
  SELECT 
    e.entity_value::jsonb as json_val 
    ,t_tab::jsonb as t_tab
  FROM public.finebi_s_update_en e
  cross join lateral jsonb_array_elements(e.entity_value::jsonb -> 'timeList') AS t_tab
  where value_class = 'UpdateSchedulerPO'
) o
)
select 
	id
	,replace(timelist_frequency_type::text,'"','') as timelist_frequency_type
	,timelist_frequency_value_unit as timelist_frequency_value_unit
	,replace(timelist_cron::text,'"','') as timelist_cron
	,case 
	when replace(timelist_frequency_type::text,'"','') = '1' then replace(timelist_cron::text,'"','') 
	when replace(timelist_frequency_type::text,'"','') = '3' then replace(timelist_cron::text,'"','') 
	when replace(timelist_frequency_type::text,'"','') = '4' then replace(timelist_cron::text,'"','') 
	when replace(timelist_frequency_type::text,'"','') = '2' then 
	  '0 '||extract(minute from to_timestamp(timelist_starttime::bigint/1000)::timestamp)||' '||extract(hour from to_timestamp(timelist_starttime::bigint/1000)::timestamp)||'/'||
	  (case when try_cast_int(replace(timelist_cron::text,'"','')) > 3600000 then (24/(timelist_frequency_value_space::int))::text else '1' end)
	  ||' ? * * *'
	else null
	end
	as timelist_cron_uni
	,24/timelist_frequency_value_space::int as interval_hour
	,timelist_frequency_value_space as timelist_frequency_value_space
	,replace(timelist_taskname::text,'"','') as timelist_taskname
	,replace(replace(timelist_taskname::text,'"',''),'Update task','') as timelist_taskname_clear
	,timelist_type
	,to_timestamp(timelist_endtime::bigint/1000)::timestamp as timelist_endtime
	,to_timestamp(timelist_starttime::bigint/1000)::timestamp as timelist_starttime
	,"content" 
from ds_s_ent;
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
