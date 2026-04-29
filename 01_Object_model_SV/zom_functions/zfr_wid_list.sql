--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wid_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wid_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_wid_list;
--
insert into public.z01_wid_list
with
t_widgets as (
  select 
    replace((entity_value::jsonb -> 'widgetId')::text,'"','') as wdm_id
    ,replace((entity_value::jsonb -> 'name')::text,'"','') as wdm_name
    ,replace((entity_value::jsonb -> 'createBy')::text,'"','') as wdm_creator_id
    ,u.username as wdm_creator
    ,to_timestamp((entity_value::jsonb -> 'initTime')::bigint/1000)::timestamp as wdm_init_time
  from public.finebi_widget_index_en w
  left join public.fine_user u on u.id = replace((entity_value::jsonb -> 'createBy')::text,'"','')
  where w.namespace = 'WidgetIndex'
),
t_wid_ut as (
  select 
    replace(entity_key,'"','') as entity_key  
    ,to_timestamp(entity_value::bigint/1000)::timestamp as wdm_update_time 
  from public.finebi_widget_index_en
  where namespace = 'WidgetUpdateTime'
)
select 
	 w.wdm_id
	,w.wdm_name
	,w.wdm_creator_id
	,w.wdm_creator
	,w.wdm_init_time
	,u.wdm_update_time
from t_widgets w
left join t_wid_ut u on u.entity_key=w.wdm_id;
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
