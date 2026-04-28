--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_app_uptime()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_app_uptime';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_app_uptime;
--
insert into public.z01_app_uptime
with
t_uptime as (
select 
	split_part(i.biversion,'-',1) as biversion
	,startupuser
	,to_timestamp(startuptime::bigint/1000)::timestamp as startuptime_cur 
	,coalesce( lag(to_timestamp(startuptime::bigint/1000)::timestamp) over (order by startuptime),to_timestamp(startuptime::bigint/1000)::timestamp)  as startuptime_prev
	,extract(hour from (to_timestamp(startuptime::bigint/1000)::timestamp
	- lag(to_timestamp(startuptime::bigint/1000)::timestamp) over (order by startuptime)
	)) as uptime
from public.fine_startup_info i
order by 2 desc
)
select 
	biversion
	,startupuser
	,startuptime_cur
	,startuptime_prev
	,extract(hour from (startuptime_cur-startuptime_prev)) as uptime
	,case when extract(hour from (startuptime_cur-startuptime_prev))<1 then 1 else 0 end as is_restart
from t_uptime
;
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
