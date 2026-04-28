--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_table_path(start_table_id text, start_table_name text, current_table_id text, current_table_name text, current_path_id text, current_path_name text, current_level integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    link RECORD;
    max_depth INTEGER := 10;
    last_link RECORD;
BEGIN
    -- ищем все связи для текущего датасета
    FOR link IN
        SELECT * 
        FROM public.z01_ds_table2parent
        WHERE dsm_table_id_from = current_table_id
    LOOP
        -- запоминаем последнее звено цепочки
        last_link := link;
				-- создание новой цепочки
        INSERT INTO public.z01_ds_table_lineage_for_each (
            start_table_id,
            start_table_name,
            path_id,
            path_name,
            level,
            end_table_id,
            end_table_name,
            end_table_type
        ) VALUES (
            start_table_id,
            start_table_name,
            current_path_id || ' -> (' || link.dsm_table_type_to || ') ' || link.dsm_table_id_to,
            current_path_name || ' -> (' || link.dsm_table_type_to || ') ' || link.dsm_table_name_to,
            current_level + 1,
            link.dsm_table_id_to,
            link.dsm_table_name_to,
            link.dsm_table_type_to
        );
        -- если текущий элемент типа ANALYSIS и мы не превысили максимальную глубину, 
        -- продолжаем построение пути
        IF current_level + 1 < max_depth 
        	and link.dsm_table_type_to = 'analysis' 
        	then
        	  PERFORM public.zfr_ds_table_path(
                start_table_id,
                start_table_name,
                link.dsm_table_id_to,
                link.dsm_table_name_to,
                current_path_id || ' -> (' || link.dsm_table_type_to || ') ' || link.dsm_table_id_to,
                current_path_name || ' -> (' || link.dsm_table_type_to || ') ' || link.dsm_table_name_to,
                current_level + 1
            );
        END IF;
    END LOOP;
END;
$function$
;
COMMENT ON FUNCTION public.zfr_ds_table_path(text, text, text, text, text, text, int4) IS 'ds origin #3.2 from z01_ds_table2parent';
--
