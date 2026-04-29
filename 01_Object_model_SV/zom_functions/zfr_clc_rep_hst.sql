--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_clc_rep_hst()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_clc_rep_hst';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_clc_rep_hst;
--
insert into public.z01_clc_rep_hst
with
t_start_dt as (
	select date'2025-01-01' as start_dt
),
t_rep2clc_temp as (
	select 
		r.id as clc_id
		,r.templateid as templateid
		,coalesce(lag(r.templateid) over (partition by r.id order by r.time_op asc),r.templateid) as prev_templateid
		,r.time_op::date dt_change
		,coalesce(lag(r.time_op) over (partition by r.id order by r.time_op asc),t.start_dt) as dt_prev
		,row_number() over (partition by r.id order by r.time_op) as rn
	from public.zst_fine_bi_report_expand r
	join t_start_dt t on 1=1
	where r.type_op in ('insert','update')
	order by r.id, r.time_op
),
t_rep2clc_temp_max as (
	select clc_id, max(rn) as max_rn
	from t_rep2clc_temp
	group by clc_id
),
t_rep2clc as (
	select distinct
		 p.clc_id
		,p.rn
		,m.max_rn
		,p.templateid
		,dt_change::date as dt_from_calc
		,case 
				when p.rn = m.max_rn then current_date
				when p.rn = 1 then dt_change
				else dt_prev 
		end::date as dt_till_calc
	from t_rep2clc_temp p
	left join t_rep2clc_temp_max m on p.clc_id=m.clc_id
	order by 1,2
)
select * 
from t_rep2clc
order by clc_id, dt_from_calc;
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
