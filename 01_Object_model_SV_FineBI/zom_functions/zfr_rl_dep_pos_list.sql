--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_rl_dep_pos_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_rl_dep_pos_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_rl_dep_pos_list;
--
insert into public.z01_rl_dep_pos_list
with recursive cte (id, name, parentId, path, level) as (
	select     
		p.id
		,p.name as name
		,p.parentId
		,p.name::text as path
		,1 as level
	from public.fine_department p
		union all
	select 
		p.id
		,p.name as name
		,p.parentId
		,concat(cte.path,'$',p.name)::text as path
		,cte.level + 1 as level
	from public.fine_department p
	inner join cte
	on cte.id = p.parentId
),
t_buf_path as (
	select
		id
		,name
		,level
		,concat(path,'$') as path
		,split_part(path,'$',1) as p1
		,split_part(path,'$',2) as p2
		,split_part(path,'$',3) as p3
		,split_part(path,'$',4) as p4
		,split_part(path,'$',5) as p5
		,split_part(path,'$',6) as p6
		,split_part(path,'$',7) as p7
		,split_part(path,'$',8) as p8
		,split_part(path,'$',9) as p9
		,split_part(path,'$',10) as p10		
		,replace(path,'$',' -> ') as path_ui
		,row_number() over (partition by id order by length(path) desc) as rn
	from cte c
),
pos_dep as (
  -- position для всех departments
  select distinct
    rd.departmentId
    ,d.name as dep_name
    ,p.name as pos_name
  from public.fine_user_role_middle rm 
  -- on u.id = rm.userId
  left join public.fine_custom_role rc on rm.roleType = 2 and rm.roleId = rc.id
  left join public.fine_dep_role rd on rm.roleType = 1 and rm.roleId = rd.id
  left join public.fine_department d on d.id = rd.departmentId
  left join public.fine_post p on p.id = rd.postId
  where rd.departmentId is not null
    and p.id is not null
)
select
  p.id as dpm_id
  ,p.name as dpm_name
  ,pd.pos_name as dpm_pos_name
  ,p.path_ui as dpm_path_ui
  ,p.level as dpm_level
  ,p.p1 as dpm_p1
  ,p.p2 as dpm_p2
  ,p.p3 as dpm_p3
  ,p.p4 as dpm_p4
  ,p.p5 as dpm_p5
  ,p.p6 as dpm_p6
  ,p.p7 as dpm_p7
  ,p.p8 as dpm_p8
  ,p.p9 as dpm_p9
  ,p.p10 as dpm_p10
from t_buf_path p
left join pos_dep pd on pd.departmentId = p.id
where rn = 1
order by path, pd.pos_name;
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
