--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ui_dir4rep_hierarhy()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ui_dir4rep_hierarhy';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z11_ui_dir4rep_hierarhy;
--
insert into public.z11_ui_dir4rep_hierarhy
with 
recursive cte (id, name, parentid, path, namepid, path_obj,expandId,deviceType,sortindex,expandtype,path_id) as (
	select     
		p.id
		,p.displayname as name
		,p.parentid
		,p.displayname::text as path
		,p.displayname as namepid
		,p.path as path_obj
		,p.expandId
		,p.deviceType
		,p.sortindex
		,p.expandtype
		,p.id::text as path_id
	from public.fine_authority_object p
	where p.expandtype in ('3','102','201')
		union all
	select     
		 p.id
		,p.displayname as name
		,p.parentid
		,concat(cte.path,'$',p.displayname)::text as path
		,p.displayname as namepid
		,p.path as path_obj
		,p.expandId
		,p.deviceType
		,p.sortindex
		,p.expandtype
		,concat(cte.path_id,'$',p.id)::text as path_id
	from public.fine_authority_object p
	inner join cte
		on cte.id = p.parentid
	where p.expandtype in ('3','102','201')
),
t_opt as (
	select public.zfx_get_env_param('env_url') as base_url
),
t_buf_path as (
	select
			c.id
			, name
			, parentid
			, replace(concat(path,'$'),'Dec-Entry_Management','01 Коллекция') as path
			, replace(replace(path,'Dec-Entry_Management','01 Коллекция'),'$',' -> ') as path_fine_bi
			,path_obj as path_dev
			,expandId
			,case when c.deviceType::int in (1,3,5,7) then 1 else 0 end as is_pc_enable
			,case when c.deviceType::int in (2,3,6,7) then 1 else 0 end as is_tablet_enable
			,case when c.deviceType::int in (4,5,6,7) then 1 else 0 end as is_phone_enable
			,row_number() over (partition by id order by length(path) desc) as rn
			,sortindex
			,expandtype
			,path_id
	from cte c
	where id not like 'decision-management-%'
),
t_finedb_dash_list as (
    select
			 t.id
			,t.name
			,t.parentid
			,t.path
			,t.path_fine_bi
			,t.path_dev
			,t.expandId
			,t.is_pc_enable
			,t.is_tablet_enable
			,t.is_phone_enable
			,t.rn
			,split_part(t.path,'$',1) as path_1
			,split_part(t.path,'$',2) as path_2
			,split_part(t.path,'$',3) as path_3
			,split_part(t.path,'$',4) as path_4
			,split_part(t.path,'$',5) as path_5
			,split_part(t.path,'$',6) as path_6
			,split_part(t.path,'$',7) as path_7
			,split_part(t.path,'$',8) as path_8
			,split_part(t.path,'$',9) as path_9
			,sortindex
			,expandtype
		,t.path_id as sd_path_id
		,split_part(t.path_id,'$',1) as sd_path_id_1
		,split_part(t.path_id,'$',2) as sd_path_id_2
		,split_part(t.path_id,'$',3) as sd_path_id_3
		,split_part(t.path_id,'$',4) as sd_path_id_4	
		,split_part(t.path_id,'$',5) as sd_path_id_5
		,split_part(t.path_id,'$',6) as sd_path_id_6
		,split_part(t.path_id,'$',7) as sd_path_id_7
		,split_part(t.path_id,'$',8) as sd_path_id_8	
		,split_part(t.path_id,'$',9) as sd_path_id_9			
    from t_buf_path t
    where rn = 1 
), 
t_upd as (
	select entity_key, entity_value as updateTime
	from public.finebi_report_index_en f 
	where namespace  = 'ReportUpdateTime'
),
t_dash2pub as (
	select *
	from public.finebi_report_index_en f
	where f.namespace = 'ReportIndex'
),
t_pub as (
	select 
		entity_key
		,case 
			when entity_value like '%\"type\":1}' then 1
			when entity_value like '%\"type\":0}' then 0
			else -1 end 
		as is_publish
	from public.finebi_report_publish_en p
	where value_class = 'ReportPublishPO'
), -- with
t_ri as (
	select id, entity_key, entity_value::jsonb as content 
	from public.finebi_report_index_en f 
	where value_class  = 'ReportIndexPO'
),
t_buf as (
select 
	id
	, entity_key
	,(content -> 'reportId')::text 	as reportId
	,(content -> 'name')::text 			as name
	,(content -> 'initTime')::text 	as initTime
	,(content -> 'createBy')::text 	as createBy
	,(content -> 'watermark')::text as waterMark
from t_ri
),
t_fine_dashboard_index as (
	-- результирующий сет
	select 
		replace(t.entity_key,'\"','') as id
		,trim(both e'\"' from t.reportId) as reportId
		,trim(both e'\"' from t.name) as name
		,trim(both e'\"' from t.createBy) as createBy
		,t.waterMark as waterMark
		,t.initTime::bigint	as initTime
		,u.updateTime::bigint 	as lastupdatetime
		,p.is_publish as is_publish
		,t.id as pub_id
	from t_buf t
	left join t_pub p on t.entity_key = p.entity_key
	left join t_upd u on t.entity_key = u.entity_key
),
t_res as (
select
	case when right(b.path_dev,4) in ('.cpt','.frm') then '02 FineReport' else '01 FineBI' end as sd_platform_name
	,(case when b.expandid is null then 0 else 1 end)::int as sm_is_publish
	,re.id::text as sm_expand_id
	,d.reportId::text as sm_report_id
	,b.name::text as sm_expand_name
	,d.name::text as sm_report_name 
	,to_timestamp(d.inittime/1000)::timestamp as sm_created_date
	,coalesce(to_timestamp(d.lastupdatetime/1000)::timestamp, null) as sm_update_date 
	,b.is_pc_enable as sm_is_pc_enable
	,b.is_tablet_enable as sm_is_tablet_enable
	,b.is_phone_enable as sm_is_phone_enable
	,case when b.id is null then '02 Неопубликовано -> 00 Developer' else replace(b.path_fine_bi,'Directory -> ','01 Коллекция -> ')::text end 	as sd_path_fine_bi
	,(case 
		when fu.username is not null then fu.realname
		when b.expandid is not null then 'Системные'
	else null end)::text as sm_dev_name
	,coalesce(fu.username,null)::text as sm_dev_login
	,case when b.expandid is null then null else concat(o.base_url||'/webroot/decision#/directory?activeTab=',b.id)::text end as sm_web_link
	,case 
		when b.id is null	then '02 Неопубликовано' 
		else b.path_1::text end as sd_path_1
	,case when b.id is null then '00 Developer' else b.path_2::text end as sd_path_2
	,case when b.id is null then dp.dpd_p2 else b.path_3::text end as sd_path_3
	,case when b.id is null then dp.dpd_p3 else b.path_4::text end as sd_path_4
	,case when b.id is null then 
		(case 
			when fu.username is not null then split_part(fu.realname,' ',1)||' ('||split_part(fu.username,'@',1)||')' else '00 Не найден владелец' 
			end)::text
		else b.path_5::text end as sd_path_5
	,b.path_6::text as sd_path_6
	,b.path_7::text as sd_path_7
	,b.path_8::text as sd_path_8
	,b.path_9::text as sd_path_9
	,b.path_dev
	,b.id
	,b.parentid
	,b.sortindex
	,b.expandtype
	,coalesce(fu.realname,'Н/Д')::text as dm_publish_name
	,coalesce(fu.username,'Н/Д')::text as dm_publish_login
	,d.createby as dm_publish_user_id
	,b.sd_path_id
	,b.sd_path_id_1
	,b.sd_path_id_2
	,b.sd_path_id_3
	,b.sd_path_id_4
	,b.sd_path_id_5
	,b.sd_path_id_6
	,b.sd_path_id_7
	,b.sd_path_id_8
	,b.sd_path_id_9
from t_fine_dashboard_index d 	
full join public.fine_bi_report_expand re 	on replace(d.reportId,'-','') = re.templateid -- eq fine_dashboard_index FineBI v5
full join t_finedb_dash_list b on re.id = b.expandid
left join public.fine_user fu on fu.id = d.createby
left join public.z01_rl_user2dep_pos dp on dp.dpd_user_id=fu.id
left join t_opt o on 1=1
)
select 
	 sd_platform_name
	,sm_is_publish
	,sm_expand_id
	,sm_is_pc_enable
	,sm_is_tablet_enable
	,sm_is_phone_enable
	,sm_report_id
	,sm_report_name
	,sm_expand_name
	,sd_path_fine_bi
	,sd_path_1
	,sd_path_2
	,coalesce(sd_path_3,'Н/у ур.2') as sd_path_3
	,coalesce(sd_path_4,'Н/у ур.3') as sd_path_4
	,sd_path_5
	,sd_path_6
	,sd_path_7
	,sd_path_8
	,sd_path_9
	,path_dev
	,sm_created_date
	,sm_update_date
	,sm_web_link
	,case when sd_path_1 = '01 Коллекция' then (length(sd_path_fine_bi)-length(replace(sd_path_fine_bi,'->','')))/2+1 else 0 end as sd_dash_lvl
	,id as pm_obj_id
	,parentid as pm_obj_parentid
	,sortindex as pm_obj_sortindex
	,expandtype as pm_obj_expandtype
	,dm_publish_name
	,dm_publish_login
	,dm_publish_user_id
	,sd_path_id
	,sd_path_id_1
	,sd_path_id_2
	,sd_path_id_3
	,sd_path_id_4
	,sd_path_id_5
	,sd_path_id_6
	,sd_path_id_7
	,sd_path_id_8
	,sd_path_id_9
from t_res t
order by 
	sd_platform_name
	,sm_is_publish desc
	,sd_path_fine_bi; 
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
