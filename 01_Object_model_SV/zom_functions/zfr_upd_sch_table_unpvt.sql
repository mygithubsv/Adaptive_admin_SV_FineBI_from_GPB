--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_upd_sch_table_unpvt()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_upd_sch_table_unpvt';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_upd_sch_table_unpvt;
insert into public.z01_upd_sch_table_unpvt
with
t_buf as (
select 
s.name, s.dir_timelist_cron_uni, s.timelist_cron_uni
  ,case 
    when t.t_hour = 1 then i-1
    else -1
  end as ex_hour
, max(t_hour) as t_hour 
from public.z01_upd_sch_table_pvt s
  cross join lateral unnest(array[h_0,h_1,h_2,h_3,h_4,h_5,h_6,h_7,h_8,h_9,h_10,h_11,h_12,h_13,h_14,h_15,h_16,h_17,h_18,h_19,h_20,h_21,h_22,h_23]) with ordinality as t(t_hour,i)
where 1=1
and (s.dir_timelist_cron_uni is not null 
or s.timelist_cron_uni is not null) 
group by 
s.name, s.dir_timelist_cron_uni, s.timelist_cron_uni
  ,case 
    when t.t_hour = 1 then i-1
    else -1
  end
order by ex_hour
)
select *
from t_buf
where ex_hour > 0
order by name, ex_hour;
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
