--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_conf()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_conf';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_conf;
--
insert into public.z01_ds_conf
with
t_ds_all as (
  select 'SPIDER' as con_type, entity_key, entity_value::jsonb as content 
  from public.finebi_s_entryconfig_en f 
  where value_class  = 'EntryDataSourcePO'
  and entity_value::text like '{"info":%'
  	union all
  select 'DIRECT' as con_type, entity_key, entity_value::jsonb as content 
  from public.finebi_d_entryconfig_en f 
  where value_class  = 'EntryDataSourcePO'
  and entity_value::text like '{"info":%'
),
t_ds_conf as (
  select 
  con_type
  ,entity_key
  ,replace(
      replace(
       (((((((content -> 'info' -> 'operatorBeans')::jsonb)[0]
       	)::jsonb -> 'tables')::jsonb)[0]
       	)::jsonb -> 'tableName')::text
      ,'\"','')
    ,'P@@@','')
    as tableName
  ,content 
  from t_ds_all f 
),
t_ds_conf_2 as (
select 
  entity_key
  ,tableName
  ,(content -> 'info' -> 'type')::text as type
  ,(content -> 'info' -> 'connectionName')::text as connectionName
  ,coalesce((content -> 'info' -> 'sql'),(content -> 'info' -> 'originSource'))::text as sql
  ,(content -> 'info' -> 'baseAttach' -> 'fileName')::text as fileName
  ,(content -> 'info' -> 'dbTableName')::text as dbTableName
  ,(content -> 'info' -> 'originSource' -> 'dbTableName')::text as dbTableName2
  ,(content -> 'info' -> 'originSource')::text as originSource
  ,content as ecf_content
from t_ds_conf t
),
t_ds_conf_3 as (
select 
  trim(both '"' from t.entity_key) as dsm_id
  ,trim(both '"' from t.type) as dsm_type
  ,trim(both '"' from t.connectionName) as dsm_conn_name
  ,trim(both '"' from t.tableName) as dsm_tablename
  ,trim(both '"' from coalesce(dbTableName,dbTableName2)) as dsm_db_tablename
  ,trim(both '"' from t.fileName) as dsm_file_name
  ,originSource as dsm_origin_source
  ,ecf_content::text as dsm_ecf_content
  ,trim(both '"' from t.sql) as dsm_sql
  ,lower(coalesce(
  					replace(replace(replace(replace(replace(replace(replace(
    					case when position('with' in t.sql) >0 then left(substring(t.sql,position('with' in t.sql),length(t.sql)),4)||E'\n' else '' end
			      	||left(substring(t.sql,position('select' in t.sql),length(t.sql)),6)||' -- // --'||E'\n'
			      	||left(substring(t.sql,position('from ' in t.sql),length(t.sql)),1000)
			      ,'\n',E'\n')
			      ,'\t',E'\t')
			      ,'\	',E'\	')
			      ,'\"',E'\"')
			      ,'"','')
			      ,'[','')
			      ,']','')
			      ,replace(t.originSource,'\", \"',E'\\", \"'),' - ' --Not extract content description
    )) as dsd_sql_preview    
	  ,case when length(t.sql)>0 then length(t.sql) else 0 end as dsd_len_sqlText
from t_ds_conf_2 t
)
select * from t_ds_conf_3;
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
