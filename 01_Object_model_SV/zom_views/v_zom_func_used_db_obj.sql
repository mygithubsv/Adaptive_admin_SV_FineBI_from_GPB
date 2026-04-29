--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE VIEW public.v_zom_func_used_db_obj
AS WITH t_func AS (
         SELECT n.nspname AS schema,
            p.proname AS fname,
            pg_get_functiondef(p.oid) AS definition
           FROM pg_proc p
             JOIN pg_type t ON p.prorettype = t.oid
             LEFT JOIN pg_description d ON p.oid = d.objoid
             LEFT JOIN pg_namespace n ON n.oid = p.pronamespace
          WHERE n.nspname ~~ '%public%'::text AND p.proname !~~ '%_ai'::text AND p.proname !~~ '%_au'::text AND p.proname !~~ '%_ad'::text
        ), t_tab AS (
         SELECT t.table_schema AS schema,
            t.table_name AS fname,
            t.table_type
           FROM information_schema.tables t
          WHERE t.table_schema::name = 'public'::name AND t.table_type::text = 'BASE TABLE'::text
        )
 SELECT tp.schema,
    tp.fname,
    'T'::text AS type,
    row_number() OVER (PARTITION BY tp.schema, tp.fname ORDER BY tp.fname) AS rn,
    tc.fname AS used_db_obj
   FROM t_func tp
     LEFT JOIN t_tab tc ON tp.definition ~~ (('%'::text || tc.fname::text) || '%'::text)
  WHERE tp.fname <> tc.fname::name
UNION ALL
 SELECT tp.schema,
    tp.fname,
    'FP'::text AS type,
    row_number() OVER (PARTITION BY tp.schema, tp.fname ORDER BY tp.fname) AS rn,
    tc.fname AS used_db_obj
   FROM t_func tp
     LEFT JOIN t_func tc ON tp.definition ~~ (('%'::text || tc.fname::text) || '%'::text)
  WHERE tp.fname <> tc.fname
  ORDER BY 1, 2, 3, 4;
COMMENT ON VIEW public.v_zom_func_used_db_obj IS 'Зависимости списка объектов ОМ (функции и таблицы), используемых в функциях';
COMMENT ON COLUMN public.v_zom_func_used_db_obj."schema" IS 'название схемы функции';
COMMENT ON COLUMN public.v_zom_func_used_db_obj.fname IS 'название функции';
COMMENT ON COLUMN public.v_zom_func_used_db_obj."type" IS 'тип используемого объекта в функции';
COMMENT ON COLUMN public.v_zom_func_used_db_obj.rn IS 'номер порядковый используемого объекта в функции';
COMMENT ON COLUMN public.v_zom_func_used_db_obj.used_db_obj IS 'используемый объект в функции';
