--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_cache_table()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_cache_table';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_cache_table;
--
insert into public.z01_ds_cache_table
select 
	 n.node_name as dsd_node_name
	,split_part(c.table_name,'_',1) as dsd_cache_table_prefix
	,case when d.dsm_id is null then 'DS not found' else 'DS found' end as dsd_ds_found
	,case when d.dsm_id is null then 0 else 1 end as dsd_is_ds_found
	,d.dsm_id 
	,d.dsm_name 
	,c.table_name as dsd_cache_table_name
	,c.exist_nodes as dsd_exist_nodes
from public.fine_bi_cluster_table_conf c
full join public.z01_ds_list d on split_part(c.table_name,'_',2) = upper(dsm_id)
join public.z01_dict_ds_exist_nodes n on 1=1
where n.is_active = 1
and c.exist_nodes like '%'||n.node_id||'%'
order by dsd_cache_table_prefix, dsd_is_ds_found, coalesce(c.table_name,d.dsm_name), n.node_name;
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
