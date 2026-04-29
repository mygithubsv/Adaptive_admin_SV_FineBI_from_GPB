--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wbk_items_relations()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddHHmmss');
	proc_name text default 'zfr_wbk_items_relations';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wbk_items_relations;
--
insert into public.z01_wbk_items_relations
with
t_descr as (  
	select 
	  trim(both '\"' from (entity_value::jsonb -> 'id')::text) as id
	  ,trim(both '\"' from (entity_value::jsonb -> 'name')::text) as name
	  ,trim(both '\"' from (entity_value::jsonb -> 'creator')::text) as creator_id
	  ,u.username as creator
	  ,to_timestamp((entity_value::jsonb -> 'configCreatedTime')::bigint/1000)::timestamp as configCreatedTime
	  ,(entity_value::jsonb -> 'type')::text as ftype
	from public.finebi_subject_en fs
	left join public.fine_user u on '"'||u.id||'"' = (entity_value::jsonb -> 'creator')::text
	where fs.namespace = 'SubjectCreate'
),
t_pid_all as (
	select 
	  trim(both '\"' from t.entity_key) as item_id
	  ,trim(both '\"' from (entity_value::jsonb -> 'pid')::text) as item_pid --dir_sandbox ?
	  ,trim(both '\"' from subItems::text) as item_cid
	from public.finebi_subject_en t
	cross join lateral jsonb_array_elements(entity_value::jsonb -> 'subIds') as subItems
	where t.namespace = 'SubjectParent'
	order by 1,2 desc
),
t_uni as (
	select item_id,item_cid
	from t_pid_all t
		union all
	select item_pid,item_cid
	from t_pid_all t
)
select 
	 u.item_id as item_pid 
	,u.item_cid
	,d1.name as name_p
	,d1.creator_id as creator_pid
	,d1.creator as creator_p
	,d1.configCreatedTime as created_pid
	,d1.ftype as ftype_pid
	,d2.name as name_c
	,d2.creator_id as creator_cid
	,d2.creator as creator_c
	,d2.configCreatedTime as created_cid
	,d2.ftype as ftype_cid
from t_uni u
left join t_descr d1 on d1.id=u.item_id
left join t_descr d2 on d2.id=u.item_cid;
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
