--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_table_lineage()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	log_res bool;
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_table_lineage';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_table_lineage;
--
insert into public.z01_ds_table_lineage
with
t_buf as (
	select 
	  n.dsm_table_id
	  ,n.dsd_table_name
	  ,n.dsm_driver_type
	  ,case 
	    when n.dsm_table_id = o.dsm_table_id_from then 'FROM'
	    when n.dsm_table_id = o.dsm_table_id_to then 'TO'
	    else 'MID'
	    end as dsd_pos_id_in_list
	  ,1 + (length(split_part(o.dsd_path_id,n.dsm_table_id,1)) - length(replace(split_part(o.dsd_path_id,n.dsm_table_id,1),'>','') )) as dsd_pos_order_num
	  ,o.dsd_level
	  ,o.dsd_path_name
	  ,o.dsd_path_name_type
	  ,o.dsd_path_id
	  ,o.dsm_table_id_to
	  ,o.dsm_table_id_from
	from public.z01_ds_table2origin o
	left join public.z01_ds_ec2tableid n on 1=1
	where o.dsd_path_id like '%'||n.dsm_table_id||'%' 
	order by n.dsd_table_name
),
t_buf2 as (
	select 
	   o.dsm_table_id_from as dsm_id_from
	  ,n.dsm_table_id as dsm_id_pass
	  ,o.dsm_table_id_to as dsm_id_to
	  ,case 
	    when o.dsm_table_id = o.dsm_table_id_from then 'FROM'
	    when o.dsm_table_id = o.dsm_table_id_to then 'TO'
	    else 'MID'
	    end as dsd_pos_id_in_list
	  ,1 + (length(split_part(o.dsd_path_id,o.dsm_table_id,1)) - length(replace(split_part(o.dsd_path_id,o.dsm_table_id,1),'>','') )) as dsd_pos_order_num
	  ,o.dsd_path_id
	  ,n.dsd_table_name
	  ,n.dsm_driver_type
	  ,o.dsd_level
	  ,o.dsd_path_name
	  ,o.dsd_path_name_type
	  ,row_number() over (partition by o.dsm_table_id_from, n.dsm_table_id order by length(o.dsd_path_id) asc) as rn
	from t_buf o
	left join public.z01_ds_ec2tableid n on 1=1
	where o.dsd_path_id like '%'||n.dsm_table_id||'%' 
	order by n.dsd_table_name
)
select 
	p.dsd_pos_id_in_list
	,1 + (length(split_part(p.dsd_path_id,p.dsm_id_pass,1)) - length(replace(split_part(p.dsd_path_id,p.dsm_id_pass,1),'>','') )) as dsd_pos_order_num
	,p.dsd_level
	,p.dsm_driver_type
	,p.dsd_table_name
	,p.dsd_path_name_type 
	,p.dsd_path_name
	,p.dsm_id_from
	,p.dsm_id_pass
	,p.dsm_id_to
	,p.dsd_path_id
from t_buf2 p 
where rn = 1
order by dsd_path_name_type;
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
COMMENT ON FUNCTION public.zfr_ds_table_lineage() IS 'ds origin #4 from (z01_ds_table2origin +z01_ds_ec2tableid )';
--
