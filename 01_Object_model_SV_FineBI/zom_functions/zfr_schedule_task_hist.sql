--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_schedule_task_hist()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_schedule_task_hist';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_schedule_task_hist;
insert into public.z01_schedule_task_hist
with 
t_fine_schedule_task_log as (
select * from (select 
 p.*
,row_number() over (partition by id order by time_op desc) as rn
from public.zst_fine_schedule_task_log p
where logtime >= extract(epoch from current_date - interval'3 month' )*1000
) where rn = 1
),
t_fine_schedule_task as (
select * from (select 
 p.type_op
,p.time_op
,p.login_op
,p.id
,p.backupfilepath
,p.conditionparameter
,p.creator
,p.editable
,p.fileclearcount
,p.nextfiretime
,p.outputstr
,p.prefiretime
,p.repeattime
,p.repeattimes
,p.scheduleoutput
,p.sendbackupfile
,p.showtype
,p.taskcondition
,p.taskdescription
,p.taskname
,p.taskparameter
,p.taskstate
,p.tasktype
,p.templatepath
,p.triggergroup
,p.usergroup
,p.stoponerror
--
,trim(both '"' from (usergroup::jsonb -> 'userType')::text) as recipient_userType
,trim(both '"' from (usergroup::jsonb -> 'departmentStr')::text) as recipient_departmentStr
,trim(both '"' from (usergroup::jsonb -> 'customRoleStr')::text) as recipient_customRoleStr
,trim(both '"' from (usergroup::jsonb -> 'platformUserStr')::text) as recipient_platformUserStr
--
,trim(both '"' from (((((triggergroup::jsonb 
	-> 'triggers')::jsonb)[0])::jsonb 
		-> 'triggerType')::text)) as scheduler_triggerType
,trim(both '"' from (((((triggergroup::jsonb 
	-> 'triggers')::jsonb)[0])::jsonb 
		-> 'startTime')::text)) as scheduler_startTime
,trim(both '"' from (((((triggergroup::jsonb 
	-> 'triggers')::jsonb)[0])::jsonb 
		-> 'endTime')::text)) as scheduler_endTime
,trim(both '"' from (((((triggergroup::jsonb 
	-> 'triggers')::jsonb)[0])::jsonb 
		-> 'startType')::text)) as scheduler_startType
,trim(both '"' from (((((triggergroup::jsonb 
	-> 'triggers')::jsonb)[0])::jsonb 
		-> 'endType')::text)) as scheduler_endType
,trim(both '"' from (((((triggergroup::jsonb 
	-> 'triggers')::jsonb)[0])::jsonb 
		-> 'repeatCount')::text)) as scheduler_repeatCount
--
,row_number() over (partition by taskname order by time_op desc) as rn
from public.zst_fine_schedule_task p
) where rn = 1
),
t_buf as (
select 
to_timestamp( b.logtime/1000)::timestamp as logtime
,tasklog
,taskid
,taskname
--
,id
,(tasklog::jsonb -> 'status')::text as status
,(tasklog::jsonb -> 'taskConditionType')::text as taskConditionType
,(tasklog::jsonb -> 'jobCountInfo' -> 'calculationJobCount')::integer as calculationJobCount
,(tasklog::jsonb -> 'jobCountInfo' -> 'userResultJobCount')::integer as userResultJobCount
,(tasklog::jsonb -> 'jobCountInfo' -> 'commonResultJobCount')::integer as commonResultJobCount
,(tasklog::jsonb -> 'jobCountInfo' -> 'restartCount')::integer as restartCount
,((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[0])::jsonb
			-> 'templateName')::text as templateName
--
,trim(both '"' from (((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[0])::jsonb
			-> 'name')::text)) as stage1_name
,trim(both '"' from (((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[1])::jsonb
			-> 'name')::text)) as stage2_name
,trim(both '"' from (((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[2])::jsonb
			-> 'name')::text)) as stage3_name
,trim(both '"' from (((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[3])::jsonb
			-> 'name')::text)) as stage4_name
--			
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[0])::jsonb
			-> 'extraInfo')::jsonb
				-> 'restartCount'))::text)::integer 
			as stage1_restartCount ---> 'baseNodes')
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[1])::jsonb
			-> 'extraInfo')::jsonb
				-> 'restartCount'))::text)::integer 
			as stage2_restartCount ---> 'baseNodes')
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[2])::jsonb
			-> 'extraInfo')::jsonb
				-> 'restartCount'))::text)::integer 
			as stage3_restartCount ---> 'baseNodes')
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[3])::jsonb
			-> 'extraInfo')::jsonb
				-> 'restartCount'))::text)::integer 
			as stage4_restartCount ---> 'baseNodes')
--
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[0])::jsonb
			-> 'extraInfo')::jsonb
				-> 'endTime'))::text)::timestamp 
			as stage1_endTime ---> 'baseNodes') 
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[1])::jsonb
			-> 'extraInfo')::jsonb
				-> 'endTime'))::text)::timestamp 
			as stage2_endTime
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[2])::jsonb
			-> 'extraInfo')::jsonb
				-> 'endTime'))::text)::timestamp 
			as stage3_endTime 
,trim(both '"' from ((((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[3])::jsonb
			-> 'extraInfo')::jsonb
				-> 'endTime'))::text)::timestamp 
			as stage4_endTime 
,((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[0])::jsonb
			-> 'status')::integer as stage1_status
,((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[1])::jsonb
			-> 'status')::integer as stage2_status
,((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[2])::jsonb
			-> 'status')::integer as stage3_status
,((((((tasklog::jsonb 
	-> 'userNodes')::jsonb)[0])::jsonb 
		-> 'baseNodes')[3])::jsonb
			-> 'status')::integer as stage4_status
from t_fine_schedule_task_log b
order by 3, 1 desc
)
select 
p.logtime::date as start_task_date
,p.logtime as start_task_dt
,coalesce(stage4_endtime,stage3_endtime,stage2_endtime,stage1_endtime) as end_task
,coalesce(stage4_endtime,stage3_endtime,stage2_endtime,stage1_endtime)-p.logtime as duration_time
,extract(epoch from coalesce(stage4_endtime,stage3_endtime,stage2_endtime,stage1_endtime)) - extract(epoch from p.logtime) as duration_sec 
,p.taskConditionType
,case 
when p.taskConditionType = '3' then 'Триггер'    
when p.taskConditionType = '0' then 'Рассылка'
else 'Другая'
end as type_task
,p.templateName
,p.taskname
,p.id
,case 
	when p.taskConditionType = '0' and coalesce(stage4_name,stage3_name) in ('1_OutputEmail') then 0
	when p.taskConditionType = '3' then 0
	else 1 end as is_error --or status_outputpng is null
,p.status as is_enable
,p.calculationJobCount
,p.userResultJobCount
,p.commonResultJobCount
,p.restartCount
--
,p.stage1_name
,p.stage2_name
,p.stage3_name
,p.stage4_name
--
,p.stage1_status
,p.stage2_status
,p.stage3_status
,p.stage4_status
--
,p.stage1_endtime
,p.stage2_endtime
,p.stage3_endtime
,p.stage4_endtime
--
,p.stage1_restartCount
,p.stage2_restartCount
,p.stage3_restartCount
,p.stage4_restartCount
--
,p.taskid
,p.tasklog
--
,t.templatepath
,t.creator
,t.taskdescription
,t.taskstate
,t.tasktype
--
--
,t.recipient_userType		
,t.recipient_departmentStr		
,t.recipient_customRoleStr		
,t.recipient_platformUserStr
--
,t.scheduler_triggerType
,t.scheduler_startTime
,t.scheduler_endTime
,t.scheduler_startType
,t.scheduler_endType		
,t.scheduler_repeatCount		
from t_buf p
join t_fine_schedule_task t
	on t.id = p.taskid
order by p.taskid, p.logtime desc;
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
