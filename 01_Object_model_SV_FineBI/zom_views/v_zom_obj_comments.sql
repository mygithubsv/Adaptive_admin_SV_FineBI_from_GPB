--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE VIEW public.v_zom_obj_comments
AS SELECT c.relname AS table_name,
    obj_description(c.oid) AS table_desc,
    a.attname AS column_name,
    d.description AS column_desc
   FROM pg_class c
     JOIN ( SELECT t_1.table_name
           FROM information_schema.tables t_1
          WHERE t_1.table_schema::name = 'public'::name AND t_1.table_type::text = 'BASE TABLE'::text) t ON t.table_name::name = c.relname
     LEFT JOIN pg_attribute a ON c.oid = a.attrelid
     LEFT JOIN pg_description d ON d.objoid = c.oid AND a.attnum = d.objsubid
  WHERE a.attnum > 0 AND (obj_description(c.oid) IS NOT NULL OR d.description IS NOT NULL)
  ORDER BY c.oid;
COMMENT ON VIEW public.v_zom_obj_comments IS 'Комментарии таблиц ОМ и их полей';
COMMENT ON COLUMN public.v_zom_obj_comments.table_name IS 'название таблицы';
COMMENT ON COLUMN public.v_zom_obj_comments.table_desc IS 'описание таблицы';
COMMENT ON COLUMN public.v_zom_obj_comments.column_name IS 'название столбца таблицы';
COMMENT ON COLUMN public.v_zom_obj_comments.column_desc IS 'описание столбца таблицы';
