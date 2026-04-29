--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_prs_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_prs_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_prs_list;
--
insert into public.z01_prs_list
with
t_buf as (
select 
	f.id
	,split_part(f.id,'.',1) as psm_id_p1
	,split_part(f.id,'.',2) as psm_id_p2
	,split_part(f.id,'.',3) as psm_id_p3
	,split_part(f.id,'.',4) as psm_id_p4
	,split_part(f.id,'.',5) as psm_id_p5
	,split_part(f.id,'.',6) as psm_id_p6
	,split_part(f.id,'.',7) as psm_id_p7
	,split_part(f.id,'.',8) as psm_id_p8
	,split_part(f.id,'.',9) as psm_id_p9
	,split_part(f.id,'.',10) as psm_id_p10
	,max(f.value) as parameter
from public.fine_conf_entity f
where id not like '%group_load%'
and id not like 'ConnectionConfig%'
and id not like 'ReportConfig%'
and id not like 'DriverLoaderConfig%'
and id not like 'ReportTablesConfig%'
and id not like 'CommonCheckedRelation%'
group by 
	f.id
	,split_part(f.id,'.',1)
	,split_part(f.id,'.',2)
	,split_part(f.id,'.',3)
	,split_part(f.id,'.',4)
	,split_part(f.id,'.',5)
	,split_part(f.id,'.',6)
	,split_part(f.id,'.',7)
	,split_part(f.id,'.',8)
	,split_part(f.id,'.',9)
	,split_part(f.id,'.',10)
)
select 
	case when psm_id_p1 like '%Config' then '01 Config' else '02 Params' end as cat_params
	,split_part(psm_id_p1,'Config',1) as subcat_params
	,split_part(id,'.',1+length(id)-length(replace(id,'.',''))) as last_par_name	
	,parameter
	,id
	,psm_id_p1
	,psm_id_p2
	,psm_id_p3
	,psm_id_p4
	,psm_id_p5
	,psm_id_p6
	,psm_id_p7
	,psm_id_p8
	,psm_id_p9
	,psm_id_p10
from t_buf
order by cat_params, subcat_params, id;
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
