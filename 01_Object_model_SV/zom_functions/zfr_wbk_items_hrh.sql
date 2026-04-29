--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wbk_items_hrh()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddHHmmss');
	proc_name text default 'zfr_wbk_items_hrh';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wbk_items_hrh;
--
insert into public.z01_wbk_items_hrh
with 
recursive cte (child_id, child_name, parent_id, parent_name, path_id, path_name, path_name_type, level) as (
  select     
	  p.item_cid as child_id
   ,p.name_c as child_name
   ,p.item_pid as parent_id
   ,p.name_p as parent_name
   ,p.item_pid as path_id
   ,p.name_p as path_name
   ,'('||p.ftype_pid||') '||p.name_p as path_name_type
   ,1 as level
  from       public.z01_wbk_items_relations p
  where p.ftype_cid = '1'
	  union all
  select     
	  p.item_cid as child_id
   ,p.name_c as child_name
   ,p.item_pid as parent_id
   ,p.name_p as parent_name
   ,CONCAT(cte.path_id,'$',p.item_pid) as path_id
   ,CONCAT(cte.path_name,'$',p.name_p) as path_name
   ,CONCAT(path_name_type,'$','('||p.ftype_pid||') '||p.name_p) as path_name_type
   ,(cte.level + 1)::int2 as level
  from       public.z01_wbk_items_relations p
  inner join cte
  on p.item_pid = cte.child_id
)
,t_buf as (
select distinct
	  child_id as wbk_id
  , child_name as wbk_name
  , level+1 as wbk_path_level
  , path_id as wbk_dir_path_id
  , path_name as wbk_dir_path_name
  , path_name_type as wbk_path_name_type
  , split_part(path_name,'$',1) as e1_name
  , split_part(path_id,'$',1) as e1_wbk_id
  , split_part(path_name,'$',2) as e2_name
  , split_part(path_id,'$',2) as e2_wbk_id
  , split_part(path_name,'$',3) as e3_name
  , split_part(path_id,'$',3) as e3_wbk_id
  , split_part(path_name,'$',4) as e4_name
  , split_part(path_id,'$',4) as e4_wbk_id
  , split_part(path_name,'$',5) as e5_name
  , split_part(path_id,'$',5) as e5_wbk_id
  , split_part(path_name,'$',6) as e6_name
  , split_part(path_id,'$',6) as e6_wbk_id
  , split_part(path_name,'$',7) as e7_name
  , split_part(path_id,'$',7) as e7_wbk_id
  , split_part(path_name,'$',8) as e8_name
  , split_part(path_id,'$',8) as e8_wbk_id
  , split_part(path_name,'$',9) as e9_name
  , split_part(path_id,'$',9) as e9_wbk_id
  , split_part(path_name,'$',10) as e10_name
  , split_part(path_id,'$',10) as e10_wbk_id
  , row_number() over (partition by child_id order by length(path_name) desc) as rn
from cte
order by path_name, wbk_path_level desc
)
select distinct 
	 p.wbk_id
	,p.wbk_name
	,p.wbk_path_level
	,replace(p.wbk_dir_path_id,'$',' -> ') as wbk_dir_path_id
	,replace(p.wbk_dir_path_name,'$',' -> ') as wbk_dir_path_name
	,replace(p.wbk_path_name_type,'$',' -> ') as wbk_dir_path_name_type
	,coalesce(u.username,p.e1_name) as e1_name
	,p.e1_wbk_id
	,p.e2_name
	,p.e2_wbk_id
	,p.e3_name
	,p.e3_wbk_id
	,p.e4_name
	,p.e4_wbk_id
	,p.e5_name
	,p.e5_wbk_id
	,p.e6_name
	,p.e6_wbk_id
	,p.e7_name
	,p.e7_wbk_id
	,p.e8_name
	,p.e8_wbk_id
	,p.e9_name
	,p.e9_wbk_id
	,p.e10_name
	,p.e10_wbk_id
from t_buf p
left join public.fine_user u on u.id=p.e1_name
where wbk_dir_path_id like '__my_analysis__%'
	and rn = 1
order by wbk_dir_path_name;
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
