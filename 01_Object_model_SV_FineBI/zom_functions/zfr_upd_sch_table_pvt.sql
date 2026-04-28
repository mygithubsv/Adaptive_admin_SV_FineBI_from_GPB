--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_upd_sch_table_pvt()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_upd_sch_table_pvt';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_upd_sch_table_pvt;
--
insert into public.z01_upd_sch_table_pvt
select 
  s.dsm_name_uniq||' ('||s.dsm_id||')' as name
  ,s.dir_timelist_cron_uni 
  ,s.timelist_cron_uni 
  ,case when dirp.h_0 = 1 or dirds.h_0 = 1 then 1 else null end as h_0
  ,case when dirp.h_1 = 1 or dirds.h_1 = 1 then 1 else null end as h_1
  ,case when dirp.h_2 = 1 or dirds.h_2 = 1 then 1 else null end as h_2
  ,case when dirp.h_3 = 1 or dirds.h_3 = 1 then 1 else null end as h_3
  ,case when dirp.h_4 = 1 or dirds.h_4 = 1 then 1 else null end as h_4
  ,case when dirp.h_5 = 1 or dirds.h_5 = 1 then 1 else null end as h_5
  ,case when dirp.h_6 = 1 or dirds.h_6 = 1 then 1 else null end as h_6
  ,case when dirp.h_7 = 1 or dirds.h_7 = 1 then 1 else null end as h_7
  ,case when dirp.h_8 = 1 or dirds.h_8 = 1 then 1 else null end as h_8
  ,case when dirp.h_9 = 1 or dirds.h_9 = 1 then 1 else null end as h_9
  ,case when dirp.h_10 = 1 or dirds.h_10 = 1 then 1 else null end as h_10
  ,case when dirp.h_11 = 1 or dirds.h_11 = 1 then 1 else null end as h_11
  ,case when dirp.h_12 = 1 or dirds.h_12 = 1 then 1 else null end as h_12
  ,case when dirp.h_13 = 1 or dirds.h_13 = 1 then 1 else null end as h_13
  ,case when dirp.h_14 = 1 or dirds.h_14 = 1 then 1 else null end as h_14
  ,case when dirp.h_15 = 1 or dirds.h_15 = 1 then 1 else null end as h_15
  ,case when dirp.h_16 = 1 or dirds.h_16 = 1 then 1 else null end as h_16
  ,case when dirp.h_17 = 1 or dirds.h_17 = 1 then 1 else null end as h_17
  ,case when dirp.h_18 = 1 or dirds.h_18 = 1 then 1 else null end as h_18
  ,case when dirp.h_19 = 1 or dirds.h_19 = 1 then 1 else null end as h_19
  ,case when dirp.h_20 = 1 or dirds.h_20 = 1 then 1 else null end as h_20
  ,case when dirp.h_21 = 1 or dirds.h_21 = 1 then 1 else null end as h_21
  ,case when dirp.h_22 = 1 or dirds.h_22 = 1 then 1 else null end as h_22
  ,case when dirp.h_23 = 1 or dirds.h_23 = 1 then 1 else null end as h_23
from public.z01_upd_sch_table s
left join public.z01_upd_sch_ds_cron_parse dirp on s.dir_timelist_cron_uni = dirp.timelist_cron_uni --select * from public.z01_upd_sch_table_cron_parse
left join public.z01_upd_sch_ds_cron_parse dirds on s.timelist_cron_uni = dirds.timelist_cron_uni
where s.dsm_name_uniq is not null
order by 1,3;
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
