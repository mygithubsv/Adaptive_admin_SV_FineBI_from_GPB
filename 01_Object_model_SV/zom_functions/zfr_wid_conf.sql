--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_wid_conf()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_wid_conf';
	rec RECORD;
	numrec integer default 0;
	sql_text text;
	is_debug int2 default 0;
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
  truncate table public.z01_wid_conf;
  -- перебираем все записи в таблице анализа
  for rec in
		select 
		  trim(both '"' from f.entity_key) as dsm_wid_id  
		  ,replace(replace((entity_value::jsonb -> 'config')::text,'"',''),'''','''''') as config_before_decode
		  ,replace(convert_from(decode(replace((entity_value::jsonb -> 'config')::text,'"',''), 'base64'), 'UTF8'),'''','''''') as config_after_decode
		--select *
		from public.finebi_widget_config_en f 
  loop
--
if is_debug = 1 then 
	begin
		numrec = numrec + 1;
		raise info '# %',numrec;
	end;
end if;
--
sql_text = '
insert into public.z01_wid_conf
with
t_wid_type as (
select 
		'''||rec.dsm_wid_id||''' as dsm_wid_id
		,'''||rec.config_before_decode||''' as config_before_decode
		,'''||rec.config_after_decode||'''::jsonb as config_after_decode
),
t_pre as (
select
	dsm_wid_id
	,config_after_decode as dsd_json_conf
	,(config_after_decode -> ''type'')::text as dsm_wid_type
	,trim(both ''"'' from (config_after_decode -> ''chartType'')::text ) as dsm_wid_chartType
	,(config_after_decode -> ''settings'' -> ''chartAttr'' -> ''type'')::text as dsm_wid_chart_type
	,(config_after_decode -> ''widgetModel'' -> ''type'')::text as dsm_wid_model
	,(config_after_decode -> ''widgetMeasures'')::text as dsm_wid_measures
	--
	,(config_after_decode -> ''view'' -> ''10000'')::text as dsm_wid_view_10000
	,(config_after_decode -> ''view'' -> ''20000'')::text as dsm_wid_view_20000
	,(config_after_decode -> ''view'' -> ''30000'')::text as dsm_wid_view_30000
	--
	,(length((config_after_decode -> ''widgetMeasures'')::text)
		-length(replace((config_after_decode -> ''widgetMeasures'')::text,''"id": "'','''')) )/length(''"id": "'')
			as dsm_cnt_wid_measures
	--
	,length((config_after_decode -> ''view'' -> ''10000'')::text)
		-length(replace((config_after_decode -> ''view'' -> ''10000'')::text,'','',''''))
		+case when (config_after_decode -> ''view'' -> ''10000'')::text like ''["%'' then 1 else 0 end
			as dsm_cnt_wid_view_10000
	,length((config_after_decode -> ''view'' -> ''20000'')::text)
		-length(replace((config_after_decode -> ''view'' -> ''20000'')::text,'','',''''))
		+case when (config_after_decode -> ''view'' -> ''20000'')::text like ''["%'' then 1 else 0 end
			as dsm_cnt_wid_view_20000
	,length((config_after_decode -> ''view'' -> ''30000'')::text)
		-length(replace((config_after_decode -> ''view'' -> ''30000'')::text,'','',''''))
		+case when (config_after_decode -> ''view'' -> ''30000'')::text like ''["%'' then 1 else 0 end
			as dsm_cnt_wid_view_30000
	--	
	,case 
		when (config_after_decode -> ''widgetModel'' -> ''type'')::text  = ''0'' 
			and (config_after_decode -> ''type'')::text = ''5'' 
			then ''Visual''
		when (config_after_decode -> ''widgetModel'' -> ''type'')::text  = ''1'' 
			then ''Table''
		else
			''Table''
			end
	as dsm_wid_model_text
from t_wid_type t
)
select 
	p.dsm_wid_id
	,p.dsm_wid_model_text
	,coalesce(''Chart.''||dsm_wid_charttype,  
	case when p.dsm_wid_model = ''0'' 
			or (dsm_wid_type = ''5'' and dsm_wid_charttype is null)
		then 
		case 
		when p.dsm_cnt_wid_view_10000 = 0 
			and p.dsm_cnt_wid_view_20000 = 0 
			and p.dsm_cnt_wid_view_30000 = 0 
			then ''Table.Empty''
		when p.dsm_cnt_wid_view_10000 > 0 
			and p.dsm_cnt_wid_view_20000 > 0 
			and p.dsm_cnt_wid_view_30000 > 0 
			then ''Table.Cross2dim''
		when (
			(p.dsm_cnt_wid_view_10000 > 0 and p.dsm_cnt_wid_view_20000 = 0) or (p.dsm_cnt_wid_view_10000 = 0 and p.dsm_cnt_wid_view_20000 > 0)
			) 
			and p.dsm_cnt_wid_view_30000 > 0 
			then ''Table.Cross1dim''
		when p.dsm_cnt_wid_view_10000 > 0 and p.dsm_cnt_wid_view_20000 = 0 and p.dsm_cnt_wid_view_30000 = 0 then ''Table.FlatHrz''
		when p.dsm_cnt_wid_view_10000 = 0 and p.dsm_cnt_wid_view_20000 > 0 and p.dsm_cnt_wid_view_30000 = 0 then ''Table.FlatVrt''
		else ''Table.NoCategory''
		end 
		else p.dsm_wid_model_text
		end) as dsm_wid_model_text_uni
	,(p.dsm_cnt_wid_view_10000 + p.dsm_cnt_wid_view_20000 + p.dsm_cnt_wid_view_30000) as dsm_cnt_wid_view
	,p.dsm_cnt_wid_view_10000||'' *''||p.dsm_cnt_wid_view_20000||'' *''||p.dsm_cnt_wid_view_30000||'' / ''||p.dsm_cnt_wid_measures as dsm_wid_elems
	,p.dsm_cnt_wid_view_10000
	,p.dsm_cnt_wid_view_20000
	,p.dsm_cnt_wid_view_30000
	,p.dsm_cnt_wid_measures
	,p.dsm_wid_measures
	,p.dsm_wid_type
	,p.dsm_wid_charttype
	,p.dsm_wid_chart_type
	,p.dsm_wid_view_10000
	,p.dsm_wid_view_20000
	,p.dsm_wid_view_30000
	,p.dsd_json_conf
from t_pre p
order by 2,1;
';
if is_debug = 1 then
	raise info 'sql_text:/n%',sql_text;
end if;
--
execute sql_text;
end loop;
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
