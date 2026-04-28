--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_log_msg_ui()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_log_msg_ui';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_log_msg_ui;
--
insert into public.z01_log_msg_ui
select 
	m.createtime 
	,m.username
	,u.realname
	,case 
	when url = 'register' then '1.1 REG'
	when url = 'sync-log' then '1.2 LOG'
	when message like 'It is detected that there may%' or
				message like 'Обнаружено, что в процессе%' then '1.3 WRN'
	when url = '#plugin/management/connection' then '2.1 CON'
	when url = 'conf/update/management%' then '2.2 UPD'
	when type = 101 and url like 'decision-directory-root/%' then '3.2 PAC'
	when type = 101 then '3.1 PRQ'
	when url = 'performance' then '4.1 URQ'
	else '---'
	end as cat
	,m.readed::int 
	,m.toasted::int 
	,null::int as is_auto_read
	,null::int as is_auto_untoasted
	,null::int as cat_value
	,m.url
	,m.message 
from public.fine_base_message m 
left join public.fine_user u on u.id = m.userid 
where 1=1
and m.userid in (
	select distinct relatedid
	from public.fine_extra_property p
	where p.name = 'extra_super_user'
);
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
