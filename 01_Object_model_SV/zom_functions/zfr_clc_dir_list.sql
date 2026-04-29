--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_clc_dir_list()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_clc_dir_list';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_clc_dir_list;
insert into public.z01_clc_dir_list
with 
recursive cte (id, name, parentid, path, namepid, description) as (
	select     
		p.id
		,p.displayname as name
		,p.parentid
		,p.displayname::text as path
		,p.displayname as namepid
		,p.description::text as description
	from public.fine_authority_object p
	where expandtype = 3
		union all
	select     
		 p.id
		,p.displayname as name
		,p.parentid
		,concat(cte.path,'$',p.displayname)::text as path
		,p.displayname as namepid
		,p.description::text
	from public.fine_authority_object p
	inner join cte
		on cte.id = p.parentid
	where expandtype = 3
),
t_buf as (
	select 
		id as dir_id
		,name as dir_name
		,path as dir_path
		,description as dir_description
		,row_number() over (partition by id order by length(path) desc) as rn 
	from cte p
) 
select 
	dir_id
	,length(dir_path)-length(replace(dir_path,'$',''))+1 as dir_lvl
	,dir_name
	,dir_description
	,replace(replace(dir_path,'Dec-Entry_Management','Коллекция'),'$',' -> ') as dir_path
	,split_part(replace(dir_path,'Dec-Entry_Management','Коллекция'),'$',1) as dir_path1
	,split_part(dir_path,'$',2) as dir_path2
	,split_part(dir_path,'$',3) as dir_path3
	,split_part(dir_path,'$',4) as dir_path4
	,split_part(dir_path,'$',5) as dir_path5
	,split_part(dir_path,'$',6) as dir_path6
	,split_part(dir_path,'$',7) as dir_path7
	,split_part(dir_path,'$',8) as dir_path8
	,split_part(dir_path,'$',9) as dir_path9
	,split_part(dir_path,'$',10) as dir_path10
from t_buf t
where rn = 1
order by dir_path;
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
