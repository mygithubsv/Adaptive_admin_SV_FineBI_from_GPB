--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_rl_user2dep_pos()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_rl_user2dep_pos';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_rl_user2dep_pos;
insert into public.z01_rl_user2dep_pos
with 
recursive cte (id, name, parentId, path, level) as (
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
	,replace(path,'$',' -> ') as path_ui
	,row_number() over (partition by id order by length(path) desc) as rn
from cte c 
),
t_p1 as (
	select
		 t.id
		,t.name
		,t.level
		,t.path
		,t.path_ui
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
		from t_buf_path t
	where rn = 1
)
select
	 pt.id as dpd_id
	,pt.name as dpd_name
	,pt.path_ui as dpd_path_ui 
	,pt.level as dpd_level
	,pt.p1 as dpd_p1
	,pt.p2 as dpd_p2
	,pt.p3 as dpd_p3
	,pt.p4 as dpd_p4
	,pt.p5 as dpd_p5
	,pt.p6 as dpd_p6
	,pt.p7 as dpd_p7
	,pt.p8 as dpd_p8
	,pt.p9 as dpd_p9
	,pt.p10 as dpd_p10
	,u.realName as dpd_user_realname
	,u.email as dpd_user_email
	,u.userId as dpd_user_id
	,replace(u.userId,'-','') as dpd_userid
	,u.username as dpd_username
from t_p1 pt
left join public.fine_dep_role as dr on dr.departmentId = pt.id
left join public.fine_post as p on p.id = dr.postId
left join (
            select m.*, u.email, u.realName, u.enable, u.username
            from public.fine_user_role_middle as m
            left join public.fine_custom_role as r on r.id = m.roleId
            left join public.fine_user as u on u.id = m.userId
) as u on u.roleId  = dr.id
order by path, email;
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
