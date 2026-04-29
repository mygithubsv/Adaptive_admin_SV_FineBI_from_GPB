--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wid_all()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wid_all';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wid_all;
insert into public.z01_wid_all
select 
	w.wdm_id
	,w.wdm_name
	,w.wdm_creator_id
	,w.wdm_creator
	,w.wdm_init_time
	,w.wdm_update_time
	--,c.dsm_wid_id
	,c.dsm_wid_model_text
	,c.dsm_wid_model_text_uni
	,c.dsm_cnt_wid_view
	,c.dsm_wid_elems
	,c.dsm_cnt_wid_view_10000
	,c.dsm_cnt_wid_view_20000
	,c.dsm_cnt_wid_view_30000
	,c.dsm_cnt_wid_measures
	,c.dsm_wid_measures
	,c.dsm_wid_type
	,c.dsm_wid_charttype
	,c.dsm_wid_chart_type
	,c.dsm_wid_view_10000
	,c.dsm_wid_view_20000
	,c.dsm_wid_view_30000
	,c.dsd_json_conf
from public.z01_wid_list w
left join public.z01_wid_conf c on w.wdm_id =c.dsm_wid_id; 
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
