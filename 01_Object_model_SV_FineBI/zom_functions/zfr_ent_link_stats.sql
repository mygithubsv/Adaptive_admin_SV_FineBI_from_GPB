--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ent_link_stats()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ent_link_stats';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
truncate table public.z01_ent_link_stats;
insert into public.z01_ent_link_stats
with
t_par as (
	select 1 as par_val, 'dashboard' as par_desc
),
t_buf as (
select
	 b.dm_dash_id as entity_id 
	,count(distinct b.dm_dash_id) as cnt_rep
	,count(distinct dw.lm_id_wid) as cnt_wid
	,count(distinct wd.lm_id_tab) as cnt_ds_all
	,count(distinct da.dsm_table_id) as cnt_ds_descr
	,count(distinct li.dsm_id_pass) as cnt_ds_origin
	,count(distinct li.dsd_path_id) as cnt_ds_path
	,count(distinct ct.cm_con_name_ui) as cnt_con
from public.z11_ui_dir4rep_hierarhy u -- + дашборды
left join public.z01_dsb_all b 
	on u.sm_expand_id = b.dm_expandid_a
left join public.z01_lnk_dsb2wid dw 
	on u.sm_report_id = dw.lm_id_rep 
left join public.z01_lnk_wid2ds wd 
	on wd.lm_id_wid = dw.lm_id_wid 
left join public.z01_wid_list w 
	on wd.lm_id_wid = w.wdm_id
left join public.z01_ds_table_lineage li 
	on li.dsm_id_from = wd.lm_id_tab
left join public.z01_ds_all da
	on da.dsm_table_id = li.dsm_id_pass
left join public.z01_con_list ct 
	on da.dsm_con_name = ct.cm_con_name_ui
where b.dm_dash_id is not null
group by 
	b.dm_dash_id
)
select 
	 b.entity_id
	,b.cnt_rep
	,b.cnt_wid
	,b.cnt_ds_all
	,b.cnt_ds_descr
	,b.cnt_ds_origin
	,b.cnt_ds_path
	,b.cnt_con
	,t.par_val
	,t.par_desc as ent_type
from t_buf b
join t_par t on 1=1;
insert into public.z01_ent_link_stats
with
t_par as (
	select 2 as par_val, 'widgets' as par_desc
),
t_buf as (
select
	 w.wdm_id as entity_id 
	,count(distinct b.dm_dash_id) as cnt_rep
	,count(distinct dw.lm_id_wid) as cnt_wid
	,count(distinct wd.lm_id_tab) as cnt_ds_all
	,count(distinct da.dsm_table_id) as cnt_ds_descr
	,count(distinct li.dsm_id_pass) as cnt_ds_origin
	,count(distinct li.dsd_path_id) as cnt_ds_path
	,count(distinct ct.cm_con_name_ui) as cnt_con
from public.z11_ui_dir4rep_hierarhy u -- + дашборды
left join public.z01_dsb_all b 
	on u.sm_expand_id = b.dm_expandid_a
left join public.z01_lnk_dsb2wid dw 
	on u.sm_report_id = dw.lm_id_rep 
left join public.z01_lnk_wid2ds wd 
	on wd.lm_id_wid = dw.lm_id_wid 
left join public.z01_wid_list w 
	on wd.lm_id_wid = w.wdm_id
left join public.z01_ds_table_lineage li 
	on li.dsm_id_from = wd.lm_id_tab
left join public.z01_ds_all da
	on da.dsm_table_id = li.dsm_id_pass
left join public.z01_con_list ct 
	on da.dsm_con_name = ct.cm_con_name_ui
where w.wdm_id is not null
group by 
	w.wdm_id
)
select 
	 b.entity_id
	,b.cnt_rep
	,b.cnt_wid
	,b.cnt_ds_all
	,b.cnt_ds_descr
	,b.cnt_ds_origin
	,b.cnt_ds_path
	,b.cnt_con
	,t.par_val
	,t.par_desc as ent_type
from t_buf b
join t_par t on 1=1;
insert into public.z01_ent_link_stats
with
t_par as (
	select 3 as par_val, 'datasets' as par_desc
),
t_buf as (
select
	da.dsm_table_id as entity_id 
	,count(distinct b.dm_dash_id) as cnt_rep
	,count(distinct w.wdm_id) as cnt_wid
	,count(distinct wd.lm_id_tab) as cnt_ds_all
	,count(distinct da.dsm_table_id) as cnt_ds_descr
	,count(distinct li.dsm_id_pass) as cnt_ds_origin
	,count(distinct li.dsd_path_id) as cnt_ds_path
	,count(distinct ct.cm_con_name_ui) as cnt_con
from public.z11_ui_dir4rep_hierarhy u -- + дашборды
left join public.z01_dsb_all b 
	on u.sm_expand_id = b.dm_expandid_a
left join public.z01_lnk_dsb2wid dw 
	on u.sm_report_id = dw.lm_id_rep 
left join public.z01_lnk_wid2ds wd 
	on wd.lm_id_wid = dw.lm_id_wid 
left join public.z01_wid_list w 
	on wd.lm_id_wid = w.wdm_id
left join public.z01_ds_table_lineage li 
	on li.dsm_id_from = wd.lm_id_tab
left join public.z01_ds_all da
	on da.dsm_table_id = li.dsm_id_pass
left join public.z01_con_list ct 
	on da.dsm_con_name = ct.cm_con_name_ui
where da.dsm_table_id is not null
group by 
	da.dsm_table_id
)
select 
	 b.entity_id
	,b.cnt_rep
	,b.cnt_wid
	,b.cnt_ds_all
	,b.cnt_ds_descr
	,b.cnt_ds_origin
	,b.cnt_ds_path
	,b.cnt_con
	,t.par_val
	,t.par_desc as ent_type
from t_buf b
join t_par t on 1=1;
insert into public.z01_ent_link_stats
with
t_par as (
	select 4 as par_val, 'connections' as par_desc
),
t_buf as (
select
	ct.cm_con_name_ui as entity_id 
	,count(distinct b.dm_dash_id) as cnt_rep
	,count(distinct w.wdm_id) as cnt_wid
	,count(distinct wd.lm_id_tab) as cnt_ds_all
	,count(distinct da.dsm_table_id) as cnt_ds_descr
	,count(distinct li.dsm_id_pass) as cnt_ds_origin
	,count(distinct li.dsd_path_id) as cnt_ds_path
	,count(distinct ct.cm_con_name_ui) as cnt_con
from public.z11_ui_dir4rep_hierarhy u -- + дашборды
left join public.z01_dsb_all b 
	on u.sm_expand_id = b.dm_expandid_a
left join public.z01_lnk_dsb2wid dw 
	on u.sm_report_id = dw.lm_id_rep 
left join public.z01_lnk_wid2ds wd 
	on wd.lm_id_wid = dw.lm_id_wid 
left join public.z01_wid_list w 
	on wd.lm_id_wid = w.wdm_id
left join public.z01_ds_table_lineage li 
	on li.dsm_id_from = wd.lm_id_tab
left join public.z01_ds_all da
	on da.dsm_table_id = li.dsm_id_pass
left join public.z01_con_list ct 
	on da.dsm_con_name = ct.cm_con_name_ui
where ct.cm_con_name_ui is not null
group by 
	ct.cm_con_name_ui
)
select 
	 b.entity_id
	,b.cnt_rep
	,b.cnt_wid
	,b.cnt_ds_all
	,b.cnt_ds_descr
	,b.cnt_ds_origin
	,b.cnt_ds_path
	,b.cnt_con
	,t.par_val
	,t.par_desc as ent_type
from t_buf b
join t_par t on 1=1;
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
