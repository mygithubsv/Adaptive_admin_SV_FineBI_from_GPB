--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_table_lineage_for_each()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
    rec record;
    max_depth integer := 10; --максимальная глубина поиска
    is_corr boolean;
    ses_id text default to_char(now(),'yyyyMMddhh24mmss');
    proc_name text default 'zfr_ds_table_lineage_for_each';
begin
  begin
	call public.zfr_proc_log(proc_name,0,ses_id);
	raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
	raise info '1. % execute', proc_name;
	is_corr = false;  
--!CODE OPERATION
  execute 'delete from public.z01_ds_table_lineage_for_each;';
  -- перебираем все записи в таблице анализа
  for rec in
      select dsm_id, dsm_name
      from public.z01_ds_list
      where dsm_driver_type = 'analysis'
  loop
      -- вызываем рекурсивную функцию для построения всех путей
      perform public.zfr_ds_table_path(
          rec.dsm_id, 
          rec.dsm_name, 
          rec.dsm_id, 
          rec.dsm_name, 
          '(analysis) ' || rec.dsm_id, 
          '(analysis) ' || rec.dsm_name, 
          0
      );
  end loop;
--#CODE OPERATION
is_corr = true;
raise info '2. % finish with state: %', proc_name, is_corr;
call public.zfr_proc_log(proc_name,1,ses_id);
return true;
exception
        when others then
        call public.zfr_proc_log(proc_name,0,ses_id,'code:'||sqlstate||'. '||left(sqlerrm,100));
       	raise info '!!! ERROR: %', sqlerrm;
        return false;
	end;
end;
$function$
;
COMMENT ON FUNCTION public.zfr_ds_table_lineage_for_each() IS 'ds origin #3.1 from (z01_ds_list + zfr_ds_table_path)';
--
