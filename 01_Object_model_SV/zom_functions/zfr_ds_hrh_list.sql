--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_hrh_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_hrh_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_hrh_list;
--
insert into public.z01_ds_hrh_list
with 
recursive cte (id, name, pid_name, parentId, path, level, entity_key_ds) as (
  select     p.dsm_id_child as id
             ,p.dsm_name_child as name
             ,p.dsm_id_parent as pid_name
             ,coalesce(p.dsm_entity_key_ds,p.dsm_id_parent) as parentid
             ,p.dsm_name_child as path
             ,1 as level
             ,p.dsm_entity_key_ds as entity_key_ds
  from       public.z01_ds_hrh_table p
  where p.dsm_id_parent is null
  union all
  select     p.dsm_id_child as id
             ,p.dsm_name_child as name
             ,p.dsm_id_parent as pid_name 
             ,CONCAT(cte.parentid,'$',p.dsm_id_parent) as parentid
             ,CONCAT(cte.path,'$',p.dsm_name_child) as path
             ,(cte.level + 1)::int2 as level
             ,p.dsm_entity_key_ds as entity_key_ds
  from       public.z01_ds_hrh_table p
  inner join cte
          on cte.id = p.dsm_id_parent
) 
,t_buf as (
select distinct
  id
  ,length(split_part(path,'$',5))
  , name as pid_name
  , parentid
  , level+1 as ds_level
  , entity_key_ds
  , path
  , split_part(path,'$',1) as e1_name
  , split_part(parentid,'$',2) as e1_pkg_ds_id
  , split_part(path,'$',2) as e2_name
  , case when length(split_part(path,'$',2))>0 then split_part(parentid||'$'||id,'$',3) else '' end as e2_pkg_ds_id
  , split_part(path,'$',3) as e3_name
  , case when length(split_part(path,'$',3))>0 then split_part(parentid||'$'||id,'$',4) else '' end as e3_pkg_ds_id
  , split_part(path,'$',4) as e4_name
  , case when length(split_part(path,'$',4))>0 then split_part(parentid||'$'||id,'$',5) else '' end as e4_pkg_ds_id
  , split_part(path,'$',5) as e5_name
  , case when length(split_part(path,'$',5))>0 then split_part(parentid||'$'||id,'$',6) else '' end as e5_pkg_ds_id
  , split_part(path,'$',6) as e6_name
  , case when length(split_part(path,'$',6))>0 then split_part(parentid||'$'||id,'$',7) else '' end as e6_pkg_ds_id
  , split_part(path,'$',7) as e7_name
  , case when length(split_part(path,'$',7))>0 then split_part(parentid||'$'||id,'$',8) else '' end as e7_pkg_ds_id
  , split_part(path,'$',8) as e8_name
  , case when length(split_part(path,'$',8))>0 then split_part(parentid||'$'||id,'$',9) else '' end as e8_pkg_ds_id
  , split_part(path,'$',9) as e9_name
  , case when length(split_part(path,'$',9))>0 then split_part(parentid||'$'||id,'$',10) else '' end as e9_pkg_ds_id
  , split_part(path,'$',10) as e10_name
  , case when length(split_part(path,'$',10))>0 then split_part(parentid||'$'||id,'$',11) else '' end as e10_pkg_ds_id
  , row_number() over (partition by coalesce(entity_key_ds,parentid) order by length(path) desc) as rn
from cte
order by path, ds_level desc
)
select 
  b.entity_key_ds as dsm_id
  ,s.dsm_name as dsm_name_uniq
  ,replace(b.path||'$'||s.dsm_name,'$',' -> ') as dsd_path_ds
  ,b.ds_level as dsm_level
  ,b.e1_name as dsd_e1_name
  ,case when length(b.e1_pkg_ds_id)=0 
  	then t.pkm_id 
  	else b.e1_pkg_ds_id end 
		as dsd_e1_pkg_ds_id
  ,b.e2_name as dsd_e2_name
  ,b.e2_pkg_ds_id as dsd_e2_pkg_ds_id
  ,b.e3_name as dsd_e3_name
  ,b.e3_pkg_ds_id as dsd_e3_pkg_ds_id
  ,b.e4_name as dsd_e4_name
  ,b.e4_pkg_ds_id as dsd_e4_pkg_ds_id
  ,b.e5_name as dsd_e5_name
  ,b.e5_pkg_ds_id as dsd_e5_pkg_ds_id
  ,b.e6_name as dsd_e6_name
  ,b.e6_pkg_ds_id as dsd_e6_pkg_ds_id
  ,b.e7_name as dsd_e7_name
  ,b.e7_pkg_ds_id as dsd_e7_pkg_ds_id
  ,b.e8_name as dsd_e8_name
  ,b.e8_pkg_ds_id as dsd_e8_pkg_ds_id
  ,b.e9_name as dsd_e9_name
  ,b.e9_pkg_ds_id as dsd_e9_pkg_ds_id
  ,b.e10_name as dsd_e10_name
  ,b.e10_pkg_ds_id as dsd_e10_pkg_ds_id
  ,replace(b.parentid||'$'||s.dsm_id,'$',' -> ') as dsd_path_ds_id
from t_buf b
left join public.z01_ds_list s on s.dsm_id = b.entity_key_ds
left join public.z01_pkg_list t on t.pkm_id=b.e1_pkg_ds_id
where rn = 1
order by path desc;
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
