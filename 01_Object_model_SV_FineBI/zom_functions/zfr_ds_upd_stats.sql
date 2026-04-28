--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_upd_stats()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_upd_stats';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_upd_stats;
--
insert into public.z01_ds_upd_stats
with
t_sel_last_24 as (
  select * from (
    select 
    t.*
    ,row_number() over (partition by tableid order by time desc) as rn 
    from public.fine_update_task_detail t
  ) o where rn < 24
),
t_buf as (
	select 
	  d.tableid
	  ,min(d.loadtype) as loadtype
	  ,max(case when d.statetype = 'SUCCESS' then to_timestamp(d.time/1000) else null end)::timestamp as last_success
	  ,max(case when d.statetype = 'WRONG' then to_timestamp(d.time/1000) else null end)::timestamp as last_wrong
	  ,count(case when d.statetype = 'WRONG' then 1 else null end) as cnt_wrong
	  ,count(*) as cnt_upd
	  ,extract(day from (now()::timestamp - max(case when d.statetype = 'SUCCESS' then to_timestamp(d.time/1000) else null end)::timestamp)) * 24 + extract(hour from (now()::timestamp - max(case when d.statetype = 'SUCCESS' then to_timestamp(d.time/1000) else null end)::timestamp)) as delta_hours_scs
	from t_sel_last_24 d
	group by d.tableid
)
select 
  tableid as dsm_id
  ,loadtype as dsm_load_type
  ,case when last_success is null then 0 else 1 end as dsd_is_corr
  ,case 
    -- 1-3 normal, 4-5   
    when delta_hours_scs between 0 and 3 then 1
    when delta_hours_scs between 3 and 12 then 2
    when delta_hours_scs between 12 and 24 then 3
    when delta_hours_scs between 24 and 72 then 4
    when delta_hours_scs > 72 then 5
    else 0  
  end as dsd_age_success_cat
  ,case 
    when round(cnt_wrong::numeric/ cnt_upd, 4) between 0 and 0.05 then 1
    when round(cnt_wrong::numeric/ cnt_upd, 4) between 0.05 and 0.20 then 2
    when round(cnt_wrong::numeric/ cnt_upd, 4) between 0.20 and 0.50 then 3
    when round(cnt_wrong::numeric/ cnt_upd, 4) between 0.50 and 0.70 then 4
    when round(cnt_wrong::numeric/ cnt_upd, 4) between 0.70 and 1.00 then 5
    else 0  
  end as dsd_err_cat
  ,cnt_wrong as dsd_cnt_wrong
  ,cnt_upd as dsd_cnt_upd
  ,round(cnt_wrong::numeric/ cnt_upd, 4) as dsd_perc_wrong
  ,last_success as dsd_last_success
  ,last_wrong as dsd_last_wrong
  ,delta_hours_scs as dsd_delta_hours_scs
from t_buf
order by dsm_load_type, dsd_perc_wrong desc, dsd_last_wrong
;
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
