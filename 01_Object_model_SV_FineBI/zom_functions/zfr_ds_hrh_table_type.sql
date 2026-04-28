--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_hrh_table_type()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_hrh_table_type';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_hrh_table_type;
--
insert into public.z01_ds_hrh_table_type
select distinct
	 p.dsm_id_child
	,p.dsm_name_child
	,coalesce(p.dsm_id_parent,'0') as dsm_id_parent
	,coalesce(p.dsm_name_parent,'Источники') as dsm_name_parent
	, 'FOLDER' as type_ent
	from public.z01_ds_hrh_table p
	where dsm_entity_key_ds is null
		union all 
	select 
	 p.dsm_entity_key_ds as dsm_id_child
	,p.dsd_trans_name as dsm_name_child
	,p.dsm_id_parent
	,p.dsm_name_parent
	, 'DS' as type_ent
from public.z01_ds_hrh_table p
where dsm_entity_key_ds is not null;
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
