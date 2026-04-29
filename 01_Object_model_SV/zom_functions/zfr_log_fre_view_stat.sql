--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_log_fre_view_stat()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_log_fre_view_stat';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_log_fre_view_stat;
--
insert into public.z01_log_fre_view_stat
select 
	s.executetype
	,s.op_type
	,s.module_name
	,s.time_event_start as time_view_start
	,extract(hour from s.time_event_start) as hour_view
	,s.consume_all
	,s.rep_name
	,s.rep_file
	,s.reportid
	,s.is_error
	,s.err_msg
	,s.node
	,s.userid
	,s.user_login
from public.z01_log_fre_fr_stat s
where executetype in (0,101,105);
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
