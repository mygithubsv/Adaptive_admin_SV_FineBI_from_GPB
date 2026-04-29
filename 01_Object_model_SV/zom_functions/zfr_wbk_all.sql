--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wbk_all()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wbk_all';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wbk_all;
--
insert into public.z01_wbk_all
with
t_superuser_list as (
	--группировка учёток superadmin
	select distinct 
		userid
	from public.fine_user_role_middle m 
	left join public.fine_user u on u.id = m.userid
	where roleid = 'super-user-custom-role'
),
t_alloc_dev2dp as (
	--отнесение пользователя на его подразделение согласно подгружаемому штатному расписанию
	select 
		z.dpd_user_id
		,z.dpd_username
		,z.dpd_user_realname
		,z.dpd_p1 as dpd_p1
		,coalesce(dd.dpd_p2_alias,z.dpd_p2) as dpd_p2
		,z.dpd_name
		,z.dpd_path_ui  
		,case when t.userid is not null then 1 else 0 end as is_superuser
	from public.z01_rl_user2dep_pos z 
	left join public.z01_rl_dep_dict dd on dd.dpd_p2=z.dpd_p2
	left join t_superuser_list t on t.userid=z.dpd_user_id
),
t_repl_path as (
	select 
		item_id
		,replace(replace(s.path_name,'$'||s.item_name,''),'$'||s.parent_name,'') as wbk_dir_path_name
	from public.z01_wbk_hrh_list s
)
select distinct 
	case 
		when r.is_superuser = 1 then '01 Admins' 
		when r.dpd_username is not null then '02 Есть ССП'
		else '01 Без ССП' end 
		as has_dpd --группировка УЗ по признаку отнесения
	,r.dpd_path_ui --полный путь иерархии УЗ
	,case when r.dpd_p1 =  'you_org' then r.dpd_p1||' '||r.dpd_p2 else r.dpd_p1 end as dpd_p1 --подразделение ур.1 из иерархии ССП для УЗ
	,r.dpd_name --подразделение в иерархии ССП для УЗ
	,s.owner_username --логин УЗ
	,r.dpd_user_realname
	--,wbi.sbj_item_parent_id as pid_dir_sandbox --каталог песочницы или её рут 
	--,case when wbi.sbj_item_parent_id like '__my_analysis__%' then 'Root' else wbi.name_subj end as pname_dir_sandbox
	,coalesce(s.e1_name,r.dpd_username) as e1_name --пространство отчёта
	,coalesce(s.e2_name,'Root') as e2_name --каталог 1 уровня
	,s.e3_name
	,s.e4_name
	,s.e5_name
	,s.e6_name
	,s.e7_name
	,s.e8_name
	,s.e9_name
	,s.e10_name
	--,h.wbk_dir_path_name_type
	,replace(sr.wbk_dir_path_name,'$',' -> ')  as wbk_dir_path_name_type --полный путь каталога размещения рабочей книги в песочницах
	,case 
		when s.item_type in ('2 ANS') then s.item_type 
		when s.item_type in ('3 DSB','4 CMP','5 DSS','6 AND') then '2 ANS'
	else null end as ans_type --РК
	,case 
		when s.item_type in ('2 ANS') then s.item_id 
		when s.item_type in ('3 DSB','4 CMP','5 DSS','6 AND') then s.parent_id
	else null end as ans_id --id РК
	,case 
		when s.item_type in ('2 ANS') then s.item_name 
		when s.item_type in ('3 DSB','4 CMP','5 DSS','6 AND') then s.parent_name
	else null end as ans_name
	,t.wbk_item_type_t as wbi_type --элемент РК
	,s.item_id as wbi_id --id элемента РК
	,s.item_name as wbi_name --название элемента РК
	,replace(replace(s.path_name,s.owner_username,s.owner_username||'$ROOT'),'$',' -> ') 
		as wbi_path_name_full --полный путь размещения элемента рабочей книги
	,t.creator as wbi_creator_id  --id создателя элемента РК
	,u.username as wbi_creator --создатель элемента РК
	,t.configcreatedtime_subj as wbi_created --время создания элемента РК
	,s.item_type as wbi_item_type --id типа элемента РК
	--,ans.itemid as ans_itemid
	,ds.dsm_ent_valid --признак валидности SSDS
	,ds.dsd_is_corr  --признак корректности обновления SSDS
from public.z01_wbk_hrh_list s
left join t_repl_path sr on sr.item_id=s.item_id 
left join public.z01_wbk_hrh_table t on s.item_id = t.id_subj 
left join t_alloc_dev2dp r on r.dpd_username = s.owner_username
left join public.fine_user u 
	on t.creator = u.id
left join public.z01_ds_all ds on ds.dsm_table_id = s.item_id 
order by 
	has_dpd
	, wbk_dir_path_name_type
	, wbi_type;
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
