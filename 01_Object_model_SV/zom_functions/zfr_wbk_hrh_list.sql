--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wbk_hrh_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wbk_hrh_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wbk_hrh_list;
--
insert into public.z01_wbk_hrh_list 
with recursive anchor (Item_id, Item_name, parent_id, path_id, path_name, level) as (
  select     
		p.id_subj as Item_id
   ,p.name_subj as Item_name
   ,p.parent_id 
   ,p.id_subj as path_id
   ,split_part(owner_username,'@',1) as path_name
   ,1 as level
  from       public.z01_wbk_hrh_table p  
  where (length(parent_id)<1 or parent_id is null)                                                     
	  union all
  select     
		p.id_subj as Item_id
   ,coalesce(d.dm_dash_name, w.wdm_name,ds.dsm_name,p.name_subj) as Item_name
   ,p.parent_id
   ,CONCAT(anchor.path_id,'$',p.id_subj) as path_id
   ,CONCAT(anchor.path_name,'$',coalesce(d.dm_dash_name, w.wdm_name,ds.dsm_name,p.name_subj)) as path_name
   ,(anchor.level + 1)::int2 as level
  from       public.z01_wbk_hrh_table p
  inner join anchor on p.parent_id = anchor.Item_id
  left join public.z01_dsb_list d on d.dm_dash_id=p.id_subj
  left join public.z01_wid_list w on w.wdm_id=p.id_subj
  left join public.z01_ds_list ds on ds.dsm_id=p.id_subj
  
)
select distinct
    h.owner_username
  , h.configcreatedtime_subj as Created_DT
  , item_id
  , h.wbk_item_type_t as item_type
  , item_name
  , a.parent_id
  , case when level = 1 then 'root' else Split_part(path_name,'$',level-1) end as parent_name
  , level as item_level
  , path_id
  , path_name
  , split_part(path_name,'$',1) as e1_name
  , split_part(path_id,'$',1) as e1_id
  , split_part(path_name,'$',2) as e2_name
  , split_part(path_id,'$',2) as e2_id
  , split_part(path_name,'$',3) as e3_name
  , split_part(path_id,'$',3) as e3_id
  , split_part(path_name,'$',4) as e4_name
  , split_part(path_id,'$',4) as e4_id
  , split_part(path_name,'$',5) as e5_name
  , split_part(path_id,'$',5) as e5_id
  , split_part(path_name,'$',6) as e6_name
  , split_part(path_id,'$',6) as e6_id
  , split_part(path_name,'$',7) as e7_name
  , split_part(path_id,'$',7) as e7_id
  , split_part(path_name,'$',8) as e8_name
  , split_part(path_id,'$',8) as e8_id
  , split_part(path_name,'$',9) as e9_name
  , split_part(path_id,'$',9) as e9_id
  , split_part(path_name,'$',10) as e10_name
  , split_part(path_id,'$',10) as e10_id
from anchor a
join public.z01_wbk_hrh_table h on h.id_subj = a.item_id
order by path_name, item_level desc
;
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
