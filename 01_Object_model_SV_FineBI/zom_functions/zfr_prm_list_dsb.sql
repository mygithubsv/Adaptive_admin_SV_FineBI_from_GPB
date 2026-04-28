--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_prm_list_dsb()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_alloc_system_resorce_dir4redirect';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_prm_list_dsb;
--
insert into public.z01_prm_list_dsb
with
t_user as (
  select
    u.id as User_ID
    ,u.username as User_name
    ,u.realName as real_name
    ,rc.id as Character_ID
    ,rc.name as role
    ,rd.id as Department_ID
    ,case when p.name is not null then 
    concat(d.name,' // Позиция: ',p.name) 
    else d.name end
    	as department
  from public.fine_user u
  left join public.fine_user_role_middle rm on u.id = rm.userId
  left join public.fine_custom_role rc on rm.roleType = 2 and rm.roleId = rc.id
  left join public.fine_dep_role rd on rm.roleType = 1 and rm.roleId = rd.id
  left join public.fine_department d on d.id = rd.departmentId
  left join public.fine_post p on p.id = rd.postId
  where 1 = 1
  	and ((rc.name not in ('Main Admin')) or rc.name is null)
),
t_fine_authority as (
	select
	  f.roleId,
	  f.authorityType,
	  a.ID,
	  a.expandid,
	  a.displayname as name,
	  a.sortindex,
	  a.parentId as parentId0,
	  f.authorityEntityType,
	  case
			when f.roleType = '1' then 'Департамент'
			when f.roleType = '2' then 'Роль'
			when f.roleType = '3' then 'Пользователь'
			when f.roleType = '4' then 'Другое'
		end as type,
		case
			when a.DEVICETYPE = '0' then 'unchecked'
			when a.DEVICETYPE = '1' then 'PC'
			when a.DEVICETYPE = '2' then 'tablet'
			when a.DEVICETYPE = '3' then 'PC, tablet'
			when a.DEVICETYPE = '4' then 'phone'
			when a.DEVICETYPE = '5' then 'PC, mobile phone'
			when a.DEVICETYPE = '6' then 'tablet, mobile phone'
			when a.DEVICETYPE = '7' then 'PC, tablet, mobile phone'
		end as applicable_platform
	from public.fine_authority_object a
	left join public.fine_authority_object b on a.parentId = b.id
	left join public.fine_authority_object c on b.parentId = c.id
	left join public.fine_authority_object d on c.parentId = d.id
	left join public.fine_authority_object e on d.parentId = e.id
	join public.fine_authority f
	    on f.authority = 2
	    and (a.id = f.authorityEntityId 
	    	or a.parentId = f.authorityEntityId 
	    	or b.parentId = f.authorityEntityId 
	    	or c.parentId = f.authorityEntityId
		    or d.parentId = f.authorityEntityId 
		    or e.parentId = f.authorityEntityId)
  --    where not exists (select 1 from fine_authority f1 where f1.authority = 1 and (a.id = f1.authorityEntityId or a.parentId = f1.authorityEntityId or b.parentId = f1.authorityEntityId or c.parentId = f1.authorityEntityId or d.parentId = f1.authorityEntityId or e.parentId = f1.authorityEntityId) and f.roleid = f1.roleid and f.authorityType = f1.authorityType)
	and a.EXPANDTYPE in ('201') -- 201: BI Report = dashboards -- ,'203')
	-- BI type (f.authorityEntityType)
	-- 201: BI data permissions
	-- 202: BI data row filter permissions (*not perceptible to the outside world)
	-- 203: BI dashboard permissions (mainly used for sharing)
	-- 204 - BI template permissions (template authentication)
	-- 205 - BI Dashboard Sharing Control (Role to Role)
	--    and f.authorityEntityType in ('201','203','204','205')
	order by a.parentId,a.sortindex
),
t_fine_dashboard_index as (
	select 
		r.id as publish_id
		, r.templateid as dash_id
	from public.fine_bi_report_expand r
),
t_buf as (
	select  
		u.user_id as userId
		,u.User_name as userName
		,u.real_name as realname
		,di.dash_id
		,fa.name as dash_name
		-- platform type
		-- 1: View permission
		-- 2: Authorization permission
		-- 3: Edit permission
		-- BI type
		-- 201: BI data usage permissions
		-- 202: BI data management permissions
		-- 203: BI report export permission
		-- 204: BI dashboard sharing permissions
		-- 205: BI template authentication authority
		-- 206: BI template viewing permissions
		-- X 207: BI template export permission
		-- 208: BI dashboard sharing role control permissions
		-- 209: BI dashboard sharing function permissions
		-- 210: BI dashboard public link function permissions
		,case 
			when fa.authorityType = 2 then '01_Auth'
			when fa.authorityType = 1 then '02_View'
			when fa.authorityType = 203 then '03_Export'
			-- when fa.authorityType = 207 then '03_Export_207'
			when fa.authorityType = 3 then '04_Edit'
			when fa.authorityType = 205 then '05_Management'
		else 'NA' end 
			as cat_perm
		,case when position('//' in u.department)>0 then 'Позиция' else fa.type end as type
		,case 
			when type = 'Пользователь' then u.User_name
			when type = 'Департамент' then u.department
			when type = 'Роль' then u.role
		else 'NA' end 
			as type_value
		,case when fa.applicable_platform like '%PC%' then 1 else 0 end as is_pc_enable
		,case when fa.applicable_platform like '%tablet%' then 1 else 0 end as is_tablet_enable
		,case when fa.applicable_platform like '%phone%' then 1 else 0 end as is_phone_enable
	from t_user u
	join t_fine_authority fa ON u.User_ID = fa.roleId 
		or u.Character_ID = fa.roleId 
		or u.Department_ID = fa.roleId 
	join t_fine_dashboard_index di on fa.expandid = di.publish_id
	where fa.authorityType in (1,2,3,203,205)
)
select distinct 
	userid as pm_user_id
	,username as pm_username
	,realname as pm_realname
	,dash_id as pm_dash_id
	,dash_name as pm_dash_name
	,cat_perm as pm_cat_perm
	,type as pm_type
	,type_value as pm_type_value
	,is_pc_enable as pm_is_pc_enable
	,is_tablet_enable as pm_is_tablet_enable
	,is_phone_enable as pm_is_phone_enable
from t_buf t1
order by t1.userName, t1.dash_id, t1.cat_perm;
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
CREATE OR REPLACE PROCEDURE public.zfr_proc_log(IN proc_name text, IN is_end integer, IN ses_id character varying DEFAULT ''::character varying, IN error_msg character varying DEFAULT ''::character varying)
 LANGUAGE plpgsql
AS $procedure$
declare
	add_date text;
begin
--
add_date = clock_timestamp();
execute '
do
$$
begin
insert into public.z01_proc_log 
(time, proc_name, is_end, ses_id, error_msg) 
values (
'''||add_date||'''
,'''||left(proc_name,100)||'''
,'||is_end||'
,'''||ses_id||'''
,'''||left(error_msg,100)||'''); 
end;
$$';
end;
$procedure$
;
--
