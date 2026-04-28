--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_table2origin()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_table2origin';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_table2origin;
--
insert into public.z01_ds_table2origin
with
t_src as (
	select 
		start_table_id as dsm_table_id_from
		,start_table_name as dsm_table_name_from
		,path_id as dsd_path_id
		,path_name as path_name_type
		,level
		,end_table_id as dsm_table_id_to
		,end_table_name as dsm_table_name_to
		,end_table_type as dsm_table_type_to
	from public.z01_ds_table_lineage_for_each t
)
select distinct
   dsm_table_name_from
  , dsm_table_name_to
  , dsm_table_type_to
  , level as dsd_level
  , path_name_type as dsd_path_name_type
  , replace(path_name_type,'(analysis) ','') as dsd_path_name
  , split_part(path_name_type,' -> ',1) as dsd_e1_name
  , split_part(path_name_type,' -> ',2) as dsd_e2_name
  , split_part(path_name_type,' -> ',3) as dsd_e3_name
  , split_part(path_name_type,' -> ',4) as dsd_e4_name
  , split_part(path_name_type,' -> ',5) as dsd_e5_name
  , split_part(path_name_type,' -> ',6) as dsd_e6_name
  --
  , split_part(path_name_type,' -> ',7) as dsd_e7_name
  , split_part(path_name_type,' -> ',8) as dsd_e8_name
  , split_part(path_name_type,' -> ',9) as dsd_e9_name
  , split_part(path_name_type,' -> ',10) as dsd_e10_name
  , split_part(path_name_type,' -> ',11) as dsd_e11_name
  , split_part(path_name_type,' -> ',12) as dsd_e12_name
  --
  , split_part(path_name_type,' -> ',13) as dsd_e13_name
  , split_part(path_name_type,' -> ',14) as dsd_e14_name
  , split_part(path_name_type,' -> ',15) as dsd_e15_name
  , split_part(path_name_type,' -> ',16) as dsd_e16_name
  , split_part(path_name_type,' -> ',17) as dsd_e17_name
  , split_part(path_name_type,' -> ',18) as dsd_e18_name
  , dsd_path_id
  , split_part(dsd_path_id,' -> ',1) as dsd_e1_id
  , dsm_table_id_from
  , dsm_table_id_to
from t_src t
order by dsm_table_id_from;
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
COMMENT ON FUNCTION public.zfr_ds_table2origin() IS 'ds origin #3.3 from z01_ds_table_lineage_for_each';
--
