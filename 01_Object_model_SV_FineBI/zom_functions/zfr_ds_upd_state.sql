--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_upd_state()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_upd_state';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_upd_state;
--
insert into public.z01_ds_upd_state
with
t_ds_upd_1 as (
  select 'SPIDER' as con_type, entity_key, entity_value::jsonb as content 
  from public.finebi_s_entrytime_en f 
  where value_class  = 'EntryDataUpdatePO'
  union all
  select 'DIRECT' as con_type, entity_key, entity_value::jsonb as content 
  from public.finebi_d_entrytime_en f 
  where value_class  = 'EntryConfigUpdatePO'
),
t_ds_upd_2 as (
select 
  entity_key
  ,con_type
  ,case when con_type = 'SPIDER' then (content -> 'dataUpdateTime')::text else null end as dataUpdateTime
  ,case when con_type = 'SPIDER' then (content -> 'syncSourceVersion')::text else (content -> 'sourceVersion')::text end as sourceVersion
  ,case when con_type = 'SPIDER' then (content -> 'syncConfigUpdateTime')::text else (content -> 'configUpdateTime')::text end as configUpdateTime
from t_ds_upd_1
),
t_ds_upd_3 as (
	select 
		trim(both '"' from t.entity_key) as dsm_id
		,con_type
		,to_timestamp(replace(dataUpdateTime,'"','')::bigint/1000)::timestamp as dsm_data_update
		,replace(sourceVersion,'"','')::int as dsm_source_version
		,to_timestamp(replace(configUpdateTime,'"','')::bigint/1000)::timestamp as dsm_config_update
	from t_ds_upd_2 t
),
t_entryvalid as (
	select 
		replace(t.entity_key,'"','') as entity_key, t.entity_value as ev_value
	from public.finebi_s_entryvalid_en t
),
t_entryswitch as (
	select 
		replace(t.entity_key,'"','') as entity_key
		,max(case when namespace = 'entryactive_s' then entity_value else null end) as ent_active
		,max(case when namespace = 'entryextract_s' then entity_value else null end) as ent_extract
		,max(case when namespace = 'entryinherit_s' then entity_value else null end) as ent_inherit
	from public.finebi_s_entryswitch_en t
	group by replace(t.entity_key,'"','')
	order by 1,2
),
t_update_set as (
	select 
		replace(t.entity_key,'"','') as entity_key
		,((entity_value::jsonb) -> 'mode')::text as mode
		,((entity_value::jsonb) -> 'updateType')::text as updateType
	from public.finebi_s_update_en t
	where namespace = 'update_s' and value_class = 'UpdatePO'
),
t_updaterec as (
select 
	replace(t.entity_key,'"','') as entity_key
	,to_timestamp(((entity_value::jsonb) -> 'lastUpdateTime')::text::bigint/1000)::timestamp as lastUpdateTime
	,to_timestamp(((entity_value::jsonb) -> 'currentUpdateTime')::text::bigint/1000)::timestamp as currentUpdateTime
from public.updaterec t
where namespace = 'tablerecord_s'
)
select 
	t.dsm_id
	,t.con_type as dsm_con_type
	,t.dsm_data_update
	,t.dsm_config_update
  ,ur.lastUpdateTime as dsm_last_update
  ,ur.currentUpdateTime as dsm_cur_update
	,t.dsm_source_version
  ,us.updateType as dsm_update_type
  ,us.mode as dsm_upd_mode
  ,ev.ev_value as dsm_ent_valid
  ,es.ent_active as dsm_ent_active
  ,es.ent_extract as dsm_ent_extract
  ,es.ent_inherit as dsm_ent_inherit
from t_ds_upd_3 t
left join t_entryvalid ev on t.dsm_id = ev.entity_key
left join t_entryswitch es on t.dsm_id = es.entity_key
left join t_update_set us on t.dsm_id = us.entity_key
left join t_updaterec ur on t.dsm_id = ur.entity_key;
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
