--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_prm_list_con()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_prm_list_con';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_prm_list_con;
--
insert into public.z01_prm_list_con
with
A as (
  select
      u.id as User_ID,
      u.username as User_name,
      u.realName as real_name,
      rc.id as Character_ID,
      rc.name as role,
      rd.id as Department_ID,
      case when p.name is not null then 
      concat(d.name,' // Позиция: ',p.name) 
      else d.name end
      as department
      ,u.email
  from public.fine_user u
  left join public.fine_user_role_middle rm on u.id = rm.userId
  left join public.fine_custom_role rc on rm.roleType = 2 and rm.roleId = rc.id
  left join public.fine_dep_role rd on rm.roleType = 1 and rm.roleId = rd.id
  left join public.fine_department d on d.id = rd.departmentId
  left join public.fine_post p on p.id = rd.postId
  where 1 = 1
),
B as (
        select
            f.roleId,
            f.authorityType,
            f.authorityEntityId as name,
            f.authorityEntityType,
            case
                when f.roleType = '1' then 'Департамент'
                when f.roleType = '2' then 'Роль'
                when f.roleType = '3' then 'Пользователь'
                when f.roleType = '4' then 'Другое'
                end as type
    from public.fine_authority f
    where f.authority = 2 -- Allow
      and f.authorityEntityType = 2 -- 2: Data connection permissions
),
t_buf as (
select  
  A.user_id as pm_user_id
  ,A.User_name as pm_username
	,A.real_name as pm_realname
  ,B.name as pm_con_name
  ,case 
  when B.authorityType = 2 then '01_Auth'
  when B.authorityType = 1 then '02_Use'
  when B.authorityType = 4 then '03_Manage'
  else 'NA' end as pm_cat_perm
  ,case when position('//' in A.department)>0 then 'Позиция' else B.type end as pd_type
  ,case 
  when type = 'Пользователь' then A.User_name
  when type = 'Департамент' then A.department
  when type = 'Роль' then A.role
  else 'NA' end as pm_type_value
  ,B.authorityType as pm_authorityType
from A
join B ON A.User_ID = B.roleId OR A.Character_ID = B.roleId OR A.Department_ID = B.roleId
)
select distinct t1.*
from t_buf t1
order by t1.pm_con_name, t1.pm_username, t1.pm_cat_perm;
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
