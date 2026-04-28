--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wbk_hrh_table()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wbk_hrh_table';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wbk_hrh_table;
--
insert into public.z01_wbk_hrh_table
with
t_subjects as (
  select 
    trim(both '"' from (entity_value::jsonb -> 'id')::text) as id_subj
    ,trim(both '"' from (entity_value::jsonb -> 'name')::text) as name_subj
    ,trim(both '"' from (entity_value::jsonb -> 'creator')::text) as creator
    ,u.username as creator_subj
    ,to_timestamp((entity_value::jsonb -> 'configCreatedTime')::bigint/1000)::timestamp as configCreatedTime_subj
    ,(entity_value::jsonb -> 'type')::text as ftype_subj
  from public.finebi_subject_en fs
  left join public.fine_user u on '"'||u.id||'"' = (entity_value::jsonb -> 'creator')::text
  where fs.namespace = 'SubjectCreate'
),
t_child2parent as (
select 
    trim(both '"' from t.entity_key) as sbj_item_parent_id
    ,trim(both '"' from subItems::text) as sbj_item_child_id
  from public.finebi_subject_en t
  cross join lateral jsonb_array_elements(entity_value::jsonb -> 'subIds') as subItems
  where t.namespace = 'SubjectParent'
union
select 
    trim(both '"' from (t.entity_value::jsonb -> 'pid')::text) as sbj_item_parent_id
    ,trim(both '"' from t.entity_key) as sbj_item_child_id   
  from public.finebi_subject_en t
  where not entity_value::jsonb ? 'subIds'
  and t.namespace = 'SubjectParent'
),
t_subjectsubitem as (
  select 
    entity_key  
    ,entity_value 
  from public.finebi_subjectsubitem_en
  where value_class = 'SubjectSubItemListPO'
),
t_subItems as (
  select 
    trim(both '"' from t.entity_key) as entity_key
    ,trim(both '"' from (subItems -> 'itemId')::text) as itemId
    ,(subItems -> 'itemType')::int as itemType
  from t_subjectsubitem t
  cross join lateral jsonb_array_elements(entity_value::jsonb -> 'subItems') as subItems
)
select 
	case when fu.id is null then 'USER DELETED' else fu.username end as owner_username
	,s.id_subj
	,s.name_subj
	,s.creator
	,s.creator_subj
	,s.configcreatedtime_subj
	,s.ftype_subj::int
	,case 
		when s.ftype_subj::int = 0 then '2 ANS' --Analysis Subject
		when s.ftype_subj::int = 1 then '1 DIR' --Directory Sandbox
	end as wbk_item_type_t
	,a2.sbj_item_parent_id as parent_id
from t_subjects s
left join public.fine_user fu on s.creator = fu.id
left join t_child2parent a2 on a2.sbj_item_child_id = s.id_subj
	union 
select 
	case when fu.id is null then 'USER DELETED' else fu.username end as owner_username
	,t.itemid as id_subj
	,s.name_subj
	,s.creator
	,s.creator_subj
	,s.configcreatedtime_subj
	,t.itemType as ftype_subj
	,case 
		when t.itemType::int = 4 then '3 DSB' --Dashboards
		when t.itemType::int = 5 then '4 CMP' --Component (widget)
		when t.itemType::int = 1 then '5 DSS' --Self-Service Dataset 
		when t.itemType::int = 6 then '6 AND' --Analysis Document
		when t.itemType::int = 2 then '7 '
	else t.itemType::text
	end as wbk_item_type_t
	,t.entity_key as parent_id
from t_subjects s
left join public.fine_user fu on s.creator = fu.id
join t_subItems t on t.entity_key = s.id_subj
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
