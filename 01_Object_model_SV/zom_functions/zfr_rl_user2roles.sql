--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_rl_user2roles()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_rl_user2roles';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_rl_user2roles;
--
insert into public.z01_rl_user2roles
select distinct
   u.id as user_id
  ,u.username as user_name
  ,u.realname as user_fio
  ,coalesce(rc.name,'Без роли') as role_name
  ,rc.id as role_id
	,us.um_is_platform as is_platform
	,us.um_is_viewer as is_viewer
	,us.um_is_dev as is_dev
from public.fine_user_role_middle rm 
full join public.fine_user u on u.id = rm.userid
full join public.fine_custom_role rc on rm.roleType = 2 and rm.roleId = rc.id
left join public.z11_usr_status us on u.id = us.um_userid
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
