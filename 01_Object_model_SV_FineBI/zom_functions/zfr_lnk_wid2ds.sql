--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_lnk_wid2ds()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_lnk_wid2ds';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_lnk_wid2ds;
--
insert into public.z01_lnk_wid2ds
with
t_wid_tab_pre as (
  select *
  from public.finebi_widget_index_en
  where namespace = 'Widget_Tables_Map'
),
t_wid2tab_buf as (
  select 
      trim(both '\"' from entity_key) as id_wid
      ,trim(both '\"' from (t_tab)::text) as id_tab
  from t_wid_tab_pre rw
  cross join lateral jsonb_array_elements(entity_value::jsonb -> 'values') as t_tab
)
select * from t_wid2tab_buf;
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
