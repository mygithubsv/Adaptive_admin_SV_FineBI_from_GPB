--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wbk_items()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wbk_items';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wbk_items;
--
insert into public.z01_wbk_items
with
t_subjects as (
  select 
    replace((entity_value::jsonb -> 'id')::text,'"','') as id_subj
    ,replace((entity_value::jsonb -> 'name')::text,'"','') as name_subj
    ,(entity_value::jsonb -> 'creator')::text as creator
    ,u.username as creator_subj
    ,to_timestamp((entity_value::jsonb -> 'configCreatedTime')::bigint/1000)::timestamp as configCreatedTime_subj
    ,(entity_value::jsonb -> 'type')::text as ftype_subj
  from public.finebi_subject_en fs
  left join public.fine_user u on u.id = replace((entity_value::jsonb -> 'creator')::text,'"','')
  where fs.namespace = 'SubjectCreate'
),
t_subjectsubitem as (
  select 
    entity_key  
    ,entity_value 
  from public.finebi_subjectsubitem_en
  where value_class = 'SubjectSubItemListPO'
),
t_pre as (
  select 
    trim(both '"' from t.entity_key) as entity_key
    ,trim(both '"' from (subItems -> 'itemId')::text) as itemId
    ,(subItems -> 'itemType')::int as itemType
  from t_subjectsubitem t
  cross join lateral jsonb_array_elements(entity_value::jsonb -> 'subItems') as subItems
),
t_ansj_elem as (
select 
  trim(both '"' from s.id_subj) as wbk_id
  ,trim(both '"' from s.name_subj) as wbk_item_name
  ,s.creator_subj as wbk_item_creator
  ,trim(both '"' from s.creator) as wbk_creator
  ,s.configcreatedtime_subj as wbk_item_created
  ,s.ftype_subj as wbk_ftype
  ,t.itemId as wbk_item_id
  ,t.itemType as wbk_item_type
	,case 
		when t.itemType::int = 4 then '3 DSB' --Dashboards
		when t.itemType::int = 5 then '4 CMP' --Component (widget)
		when t.itemType::int = 1 then '5 DSS' --Self-Service Dataset 
		when t.itemType::int = 6 then '6 AND' --Analysis Document
		when t.itemType::int = 2 then '7 ?'
		when s.ftype_subj::int = 0 then '2 ANS' --Analysis Subject
		when s.ftype_subj::int = 1 then '1 DIR' --Directory Sandbox
	else t.itemType::text
	end as wbk_item_type_t
from t_subjects s
left join t_pre t 
on s.id_subj = t.entity_key
)
select 
	 ae.wbk_id
	,ae.wbk_item_name
	,ae.wbk_item_creator
	,ae.wbk_creator
	,ae.wbk_item_created
	,ae.wbk_ftype
	,ae.wbk_item_id
	,ae.wbk_item_type
	,ae.wbk_item_type_t
from t_ansj_elem ae
order by wbk_item_name;
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
