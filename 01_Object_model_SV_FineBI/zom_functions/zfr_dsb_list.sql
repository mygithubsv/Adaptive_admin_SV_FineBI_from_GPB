--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_dsb_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_dsb_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_dsb_list;
--
insert into public.z01_dsb_list
with 
recursive cte (id, name, parentid, path, namepid, path_obj) as (
	select     
		p.id
		,p.displayname as name
		,p.parentid
		,p.displayname::text as path
		,p.displayname as namepid
		,p.path as path_obj
		,p.expandId
	from public.fine_authority_object p
		union all
	select     
		 p.id
		,p.displayname as name
		,p.parentid
		,concat(cte.path,'$',p.displayname)::text as path
		,p.displayname as namepid
		,p.path as path_obj
		,p.expandId
	from public.fine_authority_object p
	inner join cte
		on cte.id = p.parentid
),
t_opt as (
	select public.zfx_get_env_param('env_url') as base_url
),
t_buf_path as (
	select
			c.id
			, name
			, parentid
			, replace(concat(path,'$'),'Dec-Entry_Management','Directory') as path
			, replace(replace(path,'Dec-Entry_Management','Directory'),'$',' -> ') as path_fine_bi
			,path_obj as path_dev
			,expandId
			,row_number() over (partition by id order by length(path) desc) as rn
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
		,substring(t.reportId,2,length(t.reportId)-2) as reportId
		,substring(t.name,2,length(t.name)-2) as name
		,substring(t.createBy,2,length(t.createBy)-2) as createBy
		,t.waterMark	 as waterMark
		,t.initTime::bigint	as initTime
		,u.updateTime::bigint 	as lastupdatetime
		,p.is_publish as is_publish
		,t.id as pub_id
	from t_buf t
	left join t_pub p on t.entity_key = p.entity_key
	left join t_upd u on t.entity_key = u.entity_key
)
select
	coalesce(b.name,d.name||' ['||left(d.reportid,4)||'***'||right(d.reportid,4)||']')::text as dm_dash_name
	,replace(b.path_fine_bi,'Dec-Entry_Management -> ','')::text as dd_path_fine_bi
	,coalesce(b.path_1,'Sandbox')::text as dd_path_1
	,b.path_2::text as dd_path_2
	,b.path_3::text as dd_path_3
	,b.path_4::text as dd_path_4
	,b.path_5::text as dd_path_5
	,b.path_6::text as dd_path_6
	,b.path_7::text as dd_path_7
	,b.path_8::text as dd_path_8
	,b.path_9::text as dd_path_9
	,coalesce(wiu.realname,'[DELETE]') as dd_dev_name_full
	,coalesce(wiu.username,wi.wbk_creator) as dd_dev_login
	,case 
			when right(b.path_dev,4) in ('.cpt','.frm') then 'FR | Root      | '
			when b.expandid is not null then 'SV | Directory | '
			when d.reportId is not null then 'SV | Sandbox   | '
			else null 
			end || substring(b.path_dev from position(')/' in b.path_dev)+1)::text as dd_path_dev_directory --! будет уточнено после уточнения полного пути к рабочей книги
	,to_timestamp(d.inittime/1000)::timestamp as dm_createddate
	,coalesce(to_timestamp(d.lastupdatetime/1000)::timestamp, null) as dm_updatedate 
	,'Не извлечено из лога' as dm_publish_name
	,'Не извлечено из лога' as dm_publish_login
	,case 
		when b.expandid is not null then concat(o.base_url||'/webroot/decision#directory?activeTab=',b.id)::text 
		else concat(o.base_url||'/webroot/decision#/analysis/users/subject/'||wi.wbk_id||'/report/',d.reportid)::text 
	end as dm_dash_link
	,row_number() over (partition by coalesce(b.path_1,'Sandbox')::text order by path_1 asc)::int as dd_rn_dash_group
	,row_number() over (partition by coalesce(b.path_1,'Sandbox')::text, coalesce(b.path_2,coalesce(wiu.username,wi.wbk_creator)) order by b.path_2, '' asc)::int as dd_rn_dash
	,d.reportId::text as dm_dash_id
	,coalesce(dp.dm_is_shared,0) as dm_is_public_link
	,case when b.expandid is null then 0 else 1 end::int as dm_is_publish
	,b.expandid::text as dm_expandid_a
from t_fine_dashboard_index d
left join public.fine_bi_report_expand re on replace(d.reportId,'-','') = re.templateid
left join t_finedb_dash_list b on re.id = b.expandid
left join public.z01_wbk_items wi on wi.wbk_item_id = replace(d.reportId,'-','') and wi.wbk_item_type_t = '3 DSB'
left join public.fine_user wiu on wiu.id = wi.wbk_creator
left join public.z01_dsb_public_link dp on dp.dm_report_id = replace(d.reportId,'-','')
left join t_opt o on 1=1
order by dd_path_1, dd_rn_dash_group, dd_rn_dash;
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
