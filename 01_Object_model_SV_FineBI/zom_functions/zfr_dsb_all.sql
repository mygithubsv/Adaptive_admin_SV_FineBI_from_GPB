--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_dsb_all()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_dsb_all';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_dsb_all;
--
insert into public.z01_dsb_all
select 
	d.dm_dash_name
	,d.dd_path_fine_bi
	,d.dd_path_1
	,d.dd_path_2
	,d.dd_path_3
	,d.dd_path_4
	,d.dd_path_5
	,d.dd_path_6
	,d.dd_path_7
	,d.dd_path_8
	,d.dd_path_9
	,d.dd_dev_name_full
	,d.dd_dev_login
	,d.dd_path_dev_directory
	,d.dm_createddate
	,d.dm_updatedate
	,d.dm_publish_name
	,d.dm_publish_login
	,d.dm_dash_link
	,d.dd_rn_dash_group
	,d.dd_rn_dash
	,d.dm_dash_id
	,d.dm_is_public_link
	,d.dm_is_publish
	,d.dm_expandid_a
	,p.dm_username
	,p.dm_user_id
	,p.dm_link_id
	,p.dm_is_shared
	,p.dm_is_pwprotect
	,p.dm_deadline
from public.z01_dsb_list d
left join public.z01_dsb_public_link p on d.dm_dash_id = p.dm_report_id;
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
