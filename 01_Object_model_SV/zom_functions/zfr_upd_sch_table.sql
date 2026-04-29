--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_upd_sch_table()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_upd_sch_table';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_upd_sch_table;
--
insert into public.z01_upd_sch_table
select --distinct 
  case 
    when t1.timelist_cron is not null and tds.timelist_cron is not null then 11
      when t2.timelist_cron is not null and tds.timelist_cron is not null then 12
        when t3.timelist_cron is not null and tds.timelist_cron is not null then 13
          when t4.timelist_cron is not null and tds.timelist_cron is not null then 14
            when t5.timelist_cron is not null and tds.timelist_cron is not null then 15
    when t1.timelist_cron is not null then 1
      when t2.timelist_cron is not null then 2
        when t3.timelist_cron is not null then 3
          when t4.timelist_cron is not null then 4
            when t5.timelist_cron is not null then 5
              when tds.timelist_cron is not null then 10
        else 0
  end as task_lvl_dir
  --
  ,v.dsm_id
  ,v.dsm_name_uniq
  ,v.dsd_path_ds
  ,v.dsm_level
  ,v.dsd_e1_name
  ,v.dsd_e1_pkg_ds_id
  ,v.dsd_e2_name
  ,v.dsd_e2_pkg_ds_id
  ,v.dsd_e3_name
  ,v.dsd_e3_pkg_ds_id
  ,v.dsd_e4_name
  ,v.dsd_e4_pkg_ds_id
  ,v.dsd_e5_name
  ,v.dsd_e5_pkg_ds_id
  --
  ,s.dsm_name
  ,s.dsm_config_created
  ,s.dsm_driver_type
  ,s.dsm_db_name
  ,s.dsm_con_name
  ,s.dsm_creator_id
  ,s.dsm_creator_name
  ,coalesce(
     t5.id
    ,t4.id
    ,t3.id
    ,t2.id
    ,t1.id) as dir_id
  ,coalesce(
     t5.timelist_taskname
    ,t4.timelist_taskname
    ,t3.timelist_taskname
    ,t2.timelist_taskname
    ,t1.timelist_taskname) as dir_timelist_taskname
  ,coalesce(
     t5.timelist_taskname_clear
    ,t4.timelist_taskname_clear
    ,t3.timelist_taskname_clear
    ,t2.timelist_taskname_clear
    ,t1.timelist_taskname_clear) as dir_timelist_taskname_clear
  ,coalesce(
     t5.timelist_frequency_type
    ,t4.timelist_frequency_type
    ,t3.timelist_frequency_type
    ,t2.timelist_frequency_type
    ,t1.timelist_frequency_type) as dir_timelist_frequency_type
  ,coalesce(
     t5.timelist_frequency_value_unit
    ,t4.timelist_frequency_value_unit
    ,t3.timelist_frequency_value_unit
    ,t2.timelist_frequency_value_unit
    ,t1.timelist_frequency_value_unit) as dir_timelist_frequency_value_unit
  ,coalesce(
     t5.interval_hour
    ,t4.interval_hour
    ,t3.interval_hour
    ,t2.interval_hour
    ,t1.interval_hour) as dir_interval_hour
  ,coalesce(
     t5.timelist_frequency_value_space
    ,t4.timelist_frequency_value_space
    ,t3.timelist_frequency_value_space
    ,t2.timelist_frequency_value_space
    ,t1.timelist_frequency_value_space)::text as dir_timelist_frequency_value_space
  ,coalesce(
     t5.timelist_cron_uni
    ,t4.timelist_cron_uni
    ,t3.timelist_cron_uni
    ,t2.timelist_cron_uni
    ,t1.timelist_cron_uni) as dir_timelist_cron_uni
  ,coalesce(
     t5.timelist_type
    ,t4.timelist_type
    ,t3.timelist_type
    ,t2.timelist_type
    ,t1.timelist_type)::text as dir_timelist_type
  ,coalesce(
     t5.timelist_endtime
    ,t4.timelist_endtime
    ,t3.timelist_endtime
    ,t2.timelist_endtime
    ,t1.timelist_endtime) as dir_timelist_endtime
  ,coalesce(
     t5.timelist_starttime
    ,t4.timelist_starttime
    ,t3.timelist_starttime
    ,t2.timelist_starttime
    ,t1.timelist_starttime) as dir_timelist_starttime
  ,coalesce(
     t5.content
    ,t4.content
    ,t3.content
    ,t2.content
    ,t1.content)::text as dir_content
  ,tds.id
  ,tds.timelist_taskname
  ,tds.timelist_taskname_clear
  ,tds.timelist_frequency_type
  ,tds.timelist_frequency_value_unit::text as timelist_frequency_value_unit
  ,tds.interval_hour
  ,tds.timelist_frequency_value_space::text as timelist_frequency_value_space
  ,tds.timelist_cron
  ,tds.timelist_cron_uni
  ,tds.timelist_type::text as timelist_type
  ,tds.timelist_endtime
  ,tds.timelist_starttime
  ,tds.content::text as content
from public.z01_ds_hrh_list  v
left join public.z01_ds_list s on v.dsm_id  = s.dsm_id 
left join public.z01_upd_task_list t1 on t1.id = '"'||v.dsd_e1_pkg_ds_id||'"'
left join public.z01_upd_task_list t2 on t2.id = '"'||v.dsd_e2_pkg_ds_id||'"'
left join public.z01_upd_task_list t3 on t3.id = '"'||v.dsd_e3_pkg_ds_id||'"'
left join public.z01_upd_task_list t4 on t4.id = '"'||v.dsd_e4_pkg_ds_id||'"'
left join public.z01_upd_task_list t5 on t5.id = '"'||v.dsd_e5_pkg_ds_id||'"' 
left join public.z01_upd_task_list tds on tds.id = '"'||s.dsm_id||'"' 
order by v.dsd_e1_name, v.dsd_e2_name, v.dsd_e3_name, v.dsd_e4_name, v.dsd_e5_name, s.dsm_name;
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
