--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_dsb_public_link()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_dsb_public_link';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_dsb_public_link;
--
insert into public.z01_dsb_public_link
with
t_ri_1 as (
	select entity_key, entity_value::jsonb as content 
	from public.finebi_report_link_en f 
	where value_class  = 'ReportLinkPO'
),
t_buf_1 as (
select 
	entity_key
	,(content -> 'userId')::text as userId
	,(content -> 'linkId')::text as linkId
	,(content -> 'shared')::text as shared
	,(content -> 'pwProtect')::text as pwProtect
	,(content -> 'deadline')::text as deadline
from t_ri_1
),
t_res_1 as (
select 
	trim(both '\"' from t.entity_key) as entity_key
	,replace(t.userId,'\"','') as userId
	,replace(t.linkId,'\"','') as linkId
	,replace(t.shared,'\"','') as shared
	,replace(t.pwProtect,'\"','') as pwProtect
	,replace(t.deadline,'\"','') as deadline
from t_buf_1 t
)
select 
	t.entity_key as dm_report_id
	,u.username as dm_username 
	,t.userid as dm_user_id
	,t.linkid as dm_link_id
	,case when t.shared = 'true' then 1 else 0 end as dm_is_shared
	,case when t.pwprotect = 'true' then 1 else 0 end as dm_is_pwprotect
	,to_timestamp(t.deadline::bigint/1000)::timestamp as dm_deadline
from t_res_1 t
left join public.fine_user u on u.id = t.userId
order by u.username;
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
