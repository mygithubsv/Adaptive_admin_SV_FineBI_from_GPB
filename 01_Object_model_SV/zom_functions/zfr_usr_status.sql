--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_usr_status()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_usr_status';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z11_usr_status;
--
insert into public.z11_usr_status
select 
	relatedId 																												as um_userId
	,max(case when e.name like '%.platform%' then 1 else 0 end) 			as um_is_platform 
	,max(case when e.name like '%.bi_view%' then 1 else 0 end) 				as um_is_viewer 
	,max(case when e.name like '%.bi_design%' then 1 else 0 end) 			as um_is_dev 
	,max(case when e.name like '%.bi_datamining%' then 1 else 0 end) 	as um_is_datam 
from public.fine_extra_property e 
group by relatedId;
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
