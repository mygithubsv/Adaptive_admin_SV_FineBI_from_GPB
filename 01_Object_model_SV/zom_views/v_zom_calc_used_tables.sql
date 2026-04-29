--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE VIEW public.v_zom_calc_used_tables
AS WITH t_tab AS (
         SELECT t_1.table_name,
            t_1.table_type
           FROM information_schema.tables t_1
          WHERE t_1.table_schema::name = 'public'::name AND t_1.table_type::text = 'BASE TABLE'::text
        ), t_func AS (
         SELECT pg_proc.proname AS func_name,
            pg_proc.prosrc AS sql_src
           FROM pg_proc
          WHERE pg_proc.proname ~~ 'zfr_%'::text AND pg_proc.proname !~~ '%_zsv_%'::text
        )
 SELECT f.func_name,
    row_number() OVER (PARTITION BY f.func_name ORDER BY t.table_name) AS row_number,
    t.table_name,
    length(f.sql_src) AS len_sql,
    f.sql_src
   FROM t_func f
     JOIN t_tab t ON 1 = 1
  WHERE lower(f.sql_src) ~~ (('%'::text || t.table_name::text) || '%'::text) AND "substring"(t.table_name::text, 4, length(t.table_name::text)) <> "substring"(f.func_name::text, 4, length(f.func_name::text))
  ORDER BY f.func_name, (row_number() OVER (PARTITION BY f.func_name ORDER BY t.table_name));
COMMENT ON VIEW public.v_zom_calc_used_tables IS 'Код SQL функций ОМ';
COMMENT ON COLUMN public.v_zom_calc_used_tables.func_name IS 'название функции';
COMMENT ON COLUMN public.v_zom_calc_used_tables."row_number" IS 'номер таблицы в функции из кода SQL';
COMMENT ON COLUMN public.v_zom_calc_used_tables.table_name IS 'название таблицы';
COMMENT ON COLUMN public.v_zom_calc_used_tables.len_sql IS 'длина sql кода функции';
COMMENT ON COLUMN public.v_zom_calc_used_tables.sql_src IS 'sql код функции';
