--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_om_opt(mode_num integer DEFAULT 1, in_where_cond text DEFAULT ''::text)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
    is_corr boolean;
    ses_id text default to_char(now(),'yyyyMMddhh24mmss');
    proc_name text default 'zfr_om_opt';
   	rec record;
   	where_cond text default '';
		sql_query text default '';
    stage_all int2;
    stage_corr int2;
    stage_inc int2 default 0;
   	func_state_list text default '';
   	answer text default 'FAILED';
   	state int2 default 0;
   	mode_prefix text default '';
   	stats text default '';
begin
--
mode_prefix = 'mode_num: '||mode_num||', in_where_cond: ['||in_where_cond||']';
--
call public.zfr_proc_log(proc_name,0,ses_id,mode_prefix);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
is_corr := false;
--!CODE OPERATION
raise info '#############################';
raise info '### Start at %', clock_timestamp();
raise info '1. % execute', proc_name;
--
stage_all := 0;
stage_corr := 0;
--
if mode_num = 0 then
	where_cond = in_where_cond;
elseif mode_num = 1 then 
	where_cond = 'is_enable = 1 and group_num in (1,2,3)';
else where_cond = '';
end if;
--
sql_query = '
select * 
from public.z01_om_plan z 
where '||where_cond||' 
order by 
	group_num, sub_group_num;';
--
raise info 'SQL [%]:', sql_query;
--call public.zfr_proc_log(proc_name,0,ses_id);
begin
--
			select rpad('func_result',12)||rpad('|func_name',20)||rpad('|group_num',10)||rpad('|group_name',12)||rpad('|sub_group_num',15)||rpad('|sub_group_name',15) into func_state_list;
--			select e'group_num\t| group_name\t| sub_group_num\t| sub_group_name\t| func_name\t| x\t| func_result' into func_state_list;
	for rec in execute sql_query
		loop
			begin
				--
				raise info '#---------------------------#';
				raise info e'S [%] %', clock_timestamp(), rec.func_name;
				execute ('select public.'||rec.func_name||'()::int;') into stage_inc; 
				--
				stage_corr := stage_corr + stage_inc; 
				stage_all := stage_all + 1; 
				raise info e'E [%] %', clock_timestamp(), rec.func_name;
			exception
			        when others then
			        call public.zfr_proc_log(proc_name,0,ses_id,mode_prefix||' ERR code:'||sqlstate||'. '||sqlerrm);
			end;
				select 
					func_state_list||'\n'
					||rpad(''||stage_inc,12)
					||rpad('|'||rec.func_name,20)
					||rpad('|'||rec.group_num,10)
					||rpad('|'||rec.group_name,12)
					||rpad('|'||rec.sub_group_num,15)
					||rpad('|'||rec.sub_group_name,15)
				 into func_state_list;
		end loop;
	--#CODE OPERATION
	if stage_corr = stage_all then 
		begin
			answer = 'SUCCESS';
			state = 1;
		end;
	else 
		begin
			answer = 'FAILED';
			state = 0;
		end;
	end if;
	--
	stats = ' state CORR/ALL: '||stage_corr||'/'||stage_all;
	call public.zfr_proc_log(proc_name,state,ses_id,mode_prefix||stats);
	--
	execute 'select e'''||func_state_list||'''' into func_state_list;
	raise info e'LOG\n%\n%', func_state_list, stats;
	raise info '#############################';
	raise info '### Finish at %', current_timestamp;
	--
	return answer||' '||mode_prefix||stats;
	--
	exception
        when others then
        	call public.zfr_proc_log(proc_name,0,ses_id,mode_prefix||' ERR code:'||sqlstate||'. '||sqlerrm);
        return 'ERROR: code '||sqlstate||'. '||sqlerrm;
	end;
end;
$function$
;
