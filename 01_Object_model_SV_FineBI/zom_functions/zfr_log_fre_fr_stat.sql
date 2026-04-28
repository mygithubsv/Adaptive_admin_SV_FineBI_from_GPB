--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_log_fre_fr_stat()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_log_fre_fr_stat';
	last_date date default current_date; 
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
select max(time_event_start)::date from public.z01_log_fre_fr_stat into last_date;
if last_date is null then last_date = date'2024-01-01'; end if;
--
raise info 'max(time_event_start) >= %', last_date;
--
execute 'delete from public.z01_log_fre_fr_stat where time_event_start >= date'''||last_date||''';';
--
execute 'insert into public.z01_log_fre_fr_stat
select 
	e.executetype
	,et.op_code 
	,et.op_cat 
	,et.op_type 
	,et.module_name 
	,to_timestamp(e.time::bigint/1000) as time_event_start --?
	,to_timestamp(e.time::bigint/1000)::timestamp + e.consume/1000 * interval ''1 second'' as time_event_end --?
	,(e.consume/1000 * interval ''1 second'') as dur_event
	,to_timestamp(e.lastmod::bigint/1000) as last_mod_template
	,e.memory as ram_size--Report occupies memory, unit B
	,e.consume as consume_all --Including SQL execution time and report calculation time, The unit is ms
	,e.querytime as consume_query 
	,e.displayname as rep_name
	,e.tname as rep_file
	,e.reportid
	,case when "error" is not null then 1 else 0 end as is_error
	,e."error" as err_msg
	,e.node
	,e."source"
	,length(e.query) as len_query
	,(length(e.query)-length(replace(e.query,''SQL: '','''')))/length(''SQL: '') as cnt_sqlq
	,case when (length(e.query)-length(replace(e.query,''SQL: '','''')))/length(''SQL: '') > 1 then substring(replace(e.query,''SQL: '',e''\nSQL: ''),2) else e.query end as sql_text 
	,e.userid
	,split_part(split_part(e.username,''('',2),'')'',1) as user_login--,e.userrole
	,split_part(replace((e.webinfo::jsonb -> ''webResolution'')::text,''"'',''''),''*'',1) as webResolution_width
	,split_part(replace((e.webinfo::jsonb -> ''webResolution'')::text,''"'',''''),''*'',2) as webResolution_height
	,replace((e.webinfo::jsonb -> ''fullScreen'')::text,''"'','''') as fullScreen
	,date_trunc(''quarter'', to_timestamp(e.time::bigint/1000)) as year_quarter
from schema_logdb_fdw.fine_record_execute e
left join public.z01_dict_fre_op_type et on et.op_code = e.executetype
where to_timestamp(e.time::bigint/1000) >= date'''||last_date||'''
order by e.time desc
;';
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
