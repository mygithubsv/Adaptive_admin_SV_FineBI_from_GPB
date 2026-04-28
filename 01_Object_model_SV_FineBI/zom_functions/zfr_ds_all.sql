--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_all()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_all';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_all;
--
insert into public.z01_ds_all
select 
ec.dsm_table_id
,ec.dsm_table_name as dsm_table_name_uniq
,ec.dsd_table_name as dsm_table_name_ui
,ec.dsm_driver_type
--
,st.dsm_name
,st.dsm_config_created
,st.dsm_db_name
,st.dsm_con_name
,st.dsm_creator_id
,st.dsm_creator_name
--
,a.dsm_alias_name
--
,c.dsm_tablename
,c.dsm_db_tablename
,c.dsm_file_name
,c.dsm_origin_source
,c.dsm_ecf_content
,c.dsm_sql
,c.dsd_sql_preview
,c.dsd_len_sqltext
--
,h.dsd_path_ds
,h.dsm_level
,h.dsd_e1_name
,h.dsd_e1_pkg_ds_id
,h.dsd_e2_name
,h.dsd_e2_pkg_ds_id
,h.dsd_e3_name
,h.dsd_e3_pkg_ds_id
,h.dsd_e4_name
,h.dsd_e4_pkg_ds_id
,h.dsd_e5_name
,h.dsd_e5_pkg_ds_id
,h.dsd_e6_name
,h.dsd_e6_pkg_ds_id
,h.dsd_e7_name
,h.dsd_e7_pkg_ds_id
,h.dsd_e8_name
,h.dsd_e8_pkg_ds_id
,h.dsd_e9_name
,h.dsd_e9_pkg_ds_id
,h.dsd_e10_name
,h.dsd_e10_pkg_ds_id
,h.dsd_path_ds_id
--
,s.dsm_con_type
,s.dsm_data_update
,s.dsm_config_update
,s.dsm_last_update
,s.dsm_cur_update
,s.dsm_source_version
,s.dsm_update_type
,s.dsm_upd_mode
,s.dsm_ent_valid
,s.dsm_ent_active
,s.dsm_ent_extract
,s.dsm_ent_inherit
--
,t.dsm_load_type
,t.dsd_is_corr
,t.dsd_age_success_cat
,t.dsd_err_cat
,t.dsd_cnt_wrong
,t.dsd_cnt_upd
,t.dsd_perc_wrong
,t.dsd_last_success
,t.dsd_last_wrong
,t.dsd_delta_hours_scs
--
,r.columncount
,r.totalcount
,r.ds_elems
,r.ds_elems_calc
,r.cat_size_ds
,r.etlflow
,r.etlflow_short
,r.cnt_ds_ops
,r.cnt_ds_select
,r.cnt_ds_join
,r.cnt_ds_addcolumn
,r.cnt_ds_fieldsetting
,r.cnt_ds_fieldtranstype
,r.cnt_ds_filter
,r.cnt_ds_group
,r.upd_taskname
,r.upd_loadtype
,r.upd_updatetype
,r.upd_starttime
,r.upd_endtime
,r.upd_totaltime_sec
,r.upd_opentime_sec
,r.upd_writetime_sec
,r.upd_jdbctime_sec
,r.upd_statetype
,r.upd_rolename
,r.upd_runningresult
,r.upd_triggertype
,case when ec.dsm_driver_type in ('sql','db') then
coalesce(dsm_db_tablename,
	split_part(
	replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
	substring(dsm_sql from 5+position('from ' in lower(dsm_sql)))
	,'having',' having'),'order by',' order by'),'where',' where'),'--',' --'),'\n ',''),'\n',''),'"',''),'\',''),'[',''),']','') 
	,' ',1))
else ''
end as source_db_table_name
from public.z01_ds_ec2tableid ec
left join public.z01_ds_list st on st.dsm_id =ec.dsm_table_id 
left join public.z01_ds_name_alias a on a.dsm_id = ec.dsm_table_id 
left join public.z01_ds_conf c on c.dsm_id = ec.dsm_table_id 
left join public.z01_ds_hrh_list h on h.dsm_id = ec.dsm_table_id
left join public.z01_ds_upd_state s on s.dsm_id = ec.dsm_table_id
left join public.z01_ds_upd_stats t on t.dsm_id = ec.dsm_table_id
left join public.z01_ds_upd_struct r on r.tableid = ec.dsm_table_id;
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
