--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_lnk_dsb2wid()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_lnk_dsb2wid';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_lnk_dsb2wid;
--
insert into public.z01_lnk_dsb2wid
with
t_rep_wid_pre as (
  select *
  from public.finebi_report_index_en
  where namespace = 'Report_Widgets_Map'
),
t_rep2wid as (
  select 
      trim(both '\"' from entity_key) as lm_id_rep
      ,trim(both '\"' from (t_wid)::text) as lm_id_wid
  from t_rep_wid_pre rw
  cross join lateral jsonb_array_elements(entity_value::jsonb -> 'values') as t_wid
)
select * from t_rep2wid;
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
