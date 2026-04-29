--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_pkg_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_pkg_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_pkg_list;
--
insert into public.z01_pkg_list
select 
	replace(j.entity_key,'"','') as pkm_id
	,replace((j.content -> 'name')::text,'"','') as pkm_name
	,(j.content -> 'creator')::text as pkm_creator_id 
	,u.username as pkm_creator_name
	,to_timestamp((j.content -> 'configCreatedTime')::text::bigint/1000)::timestamp as pkm_config_created
from (
  select entity_key, entity_value::jsonb as content 
  from public.finebi_package_en p 
  where p.value_class = 'PackageCreatePO' 
    ) j
left join public.fine_user u on '"'||u.id||'"'=(j.content -> 'creator')::text;
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
