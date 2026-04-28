--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE VIEW public.v_zom_calc_list
AS WITH t_tab AS (
         SELECT t_1.table_name,
            t_1.table_type
           FROM information_schema.tables t_1
          WHERE t_1.table_schema::name = 'public'::name AND t_1.table_type::text = 'BASE TABLE'::text AND ("left"(t_1.table_name::text, 3) = ANY (ARRAY['z01'::text, 'z11'::text]))
        ), t_func AS (
         SELECT routines.routine_name AS function_name
           FROM information_schema.routines
          WHERE routines.routine_schema::name = 'public'::name AND routines.routine_type::text = 'FUNCTION'::text AND routines.routine_name::name !~~ 'zst_func_%'::text AND routines.routine_name::name ~~ 'zfr_%'::text
        )
 SELECT split_part(t.table_name::text, '_'::text, 2) AS group_table,
    "substring"(t.table_name::text, 2, 2) AS table_cat,
    t.table_name,
    f.function_name
   FROM t_tab t
     FULL JOIN t_func f ON replace(f.function_name::text, 'zfr'::text, ''::text) = replace(t.table_name::text, split_part(t.table_name::text, '_'::text, 1), ''::text)
  ORDER BY ("substring"(t.table_name::text, 2, 2)) DESC, (split_part(t.table_name::text, '_'::text, 2));
COMMENT ON VIEW public.v_zom_calc_list IS 'Таблицы ОМ и связанные функции БД';
COMMENT ON COLUMN public.v_zom_calc_list.group_table IS 'выделенный второй префикс таблиц для группировки';
COMMENT ON COLUMN public.v_zom_calc_list.table_cat IS 'категория таблиц (00, 01, 10, 11)';
COMMENT ON COLUMN public.v_zom_calc_list.table_name IS 'название таблицы';
COMMENT ON COLUMN public.v_zom_calc_list.function_name IS 'функция, которая используется для наполнения таблицы';
