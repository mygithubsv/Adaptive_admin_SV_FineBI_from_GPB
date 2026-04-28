--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_con_hist()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_con_hist';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_con_hist;
--
insert into public.z01_con_hist
with
t_def_init_date as (
	select date'2024-02-21' as dat
	--select min(to_timestamp(time/1000)::date) as dat from schema_logdb_fdw.fine_record_operate
),
t_test as (
	select 
		operateresource as data_connection 
		, min(case when operate = 'Dec-Log_Add' then to_timestamp(time/1000)::date  else null end) as time_add_min
		, max(case when operate = 'Dec-Log_Add' then to_timestamp(time/1000)::date  else null end) as time_add_max
		, max(case when operate = 'Dec-Log_Update' then to_timestamp(time/1000)::date else null end) as time_update_max
		, max(case when operate = 'Dec-Log_Delete' then to_timestamp(time/1000)::date else null end) as time_delete_max
		--
		, count(case when operate = 'Dec-Log_Add' then 1 else null end) as cnt_add
		, count(case when operate = 'Dec-Log_Update' then 1 else null end) as cnt_update
		, count(case when operate = 'Dec-Log_Delete' then 1 else null end) as cnt_delete
	from schema_logdb_fdw.fine_record_operate
	where item = 'Dec-Data_Connection'
	group by operateresource
)
select 
   t.data_connection as chm_data_connection
  ,case when t.time_add_max<=time_delete_max then 1 else 0 end as chd_is_delete
  ,case when t.time_add_min is null then 1 else 0 end as chd_is_def_init_date
  ,coalesce(t.time_add_min,d.dat) as chd_time_add_min
  ,t.cnt_add
  ,t.time_update_max as chm_time_update_max
  ,t.cnt_update
  ,t.time_delete_max as chm_time_delete_max
  --
  ,t.cnt_delete
  ,coalesce(current_date,t.time_delete_max)-coalesce(t.time_add_max,d.dat) as chd_conn_age_days
  ,current_date-coalesce(t.time_update_max,current_date) as chd_last_update_days
  ,current_date-coalesce(t.time_delete_max,current_date) as chd_last_delete_days
from t_test t 
join t_def_init_date d on 1=1
order by 1,2,3;
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
