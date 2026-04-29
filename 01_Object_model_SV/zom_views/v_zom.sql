--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE VIEW public.v_zom
AS 
WITH t_ds_name_list AS (
         SELECT DISTINCT TRIM(BOTH '"'::text FROM dsm_alias_name) AS table_name
           FROM public.z01_ds_name_alias
        ), t_view AS (
         SELECT COALESCE(c.group_table,
                CASE
                    WHEN c.function_name::name ~~ '%_agg_%'::text THEN split_part(c.function_name::text, '_'::text, 3)
                    ELSE split_part(c.function_name::text, '_'::text, 2)
                END) AS group_table,
            c.table_cat,
            c.function_name,
            f.table_schema,
            c.table_name,
            m.table_desc,
            f.pos_num,
                CASE
                    WHEN "right"(split_part(f.column_name::text, '_'::text, 1), 1) = 'd'::text THEN 'addt'::text
                    WHEN "right"(split_part(f.column_name::text, '_'::text, 1), 1) = 'm'::text THEN 'model'::text
                    ELSE '-'::text
                END AS column_origin,
            f.column_name,
            m.column_desc,
            f.data_type,
                CASE
                    WHEN f.data_type::text = 'text'::text OR f.data_type::text ~~ '%char%'::text THEN 'TEXT'::text
                    WHEN f.data_type::text ~~ 'time%'::text OR f.data_type::text ~~ '%date%'::text THEN 'DATE'::text
                    WHEN f.data_type::text = 'numeric'::text OR f.data_type::text ~~ '%int%'::text THEN 'NUM'::text
                    WHEN f.data_type::text ~~ 'json%'::text THEN 'JSON'::text
                    ELSE NULL::text
                END AS data_type_group,
                CASE
                    WHEN c.function_name IS NOT NULL THEN 1
                    ELSE 0
                END AS has_zfr,
                CASE
                    WHEN d.table_name IS NOT NULL THEN 1
                    ELSE 0
                END AS has_ds_in_sv,
                CASE
                    WHEN m.table_desc IS NOT NULL THEN 1
                    ELSE 0
                END AS has_table_desc,
                CASE
                    WHEN m.column_desc IS NOT NULL THEN 1
                    ELSE 0
                END AS has_column_desc,
                CASE
                    WHEN "left"(m.column_desc, 1) = ANY (ARRAY['@'::text, '>'::text, 'X'::text, '?'::text]) THEN 1
                    ELSE 0
                END AS col_state_check,
                CASE
                    WHEN "left"(m.column_desc, 1) = ANY (ARRAY['@'::text, '>'::text, 'X'::text, '?'::text]) THEN "left"(m.column_desc, 1)
                    ELSE '-'::text
                END AS col_state_dev,
                CASE
                    WHEN m.column_desc IS NULL THEN '2. Без описания'::text
                    WHEN "left"(m.column_desc, 1) = '@'::text THEN '4. Дубликат'::text
                    WHEN "left"(m.column_desc, 1) = '>'::text THEN '3. Коррекция'::text
                    WHEN "left"(m.column_desc, 1) = '*'::text THEN '5. Удаление'::text
                    WHEN "left"(m.column_desc, 1) = '?'::text THEN '6. Уточнение'::text
                    ELSE '1. Описан'::text
                END AS col_state_dev_t,
                CASE
                    WHEN "left"(m.table_desc, 1) = ANY (ARRAY['@'::text, '>'::text, 'X'::text, '?'::text]) THEN 1
                    ELSE 0
                END AS table_state_check,
                CASE
                    WHEN "left"(m.table_desc, 1) = ANY (ARRAY['@'::text, '>'::text, 'X'::text, '?'::text]) THEN "left"(m.table_desc, 1)
                    ELSE '-'::text
                END AS table_state_dev,
                CASE
                    WHEN m.table_desc IS NULL THEN '2. Без описания'::text
                    WHEN "left"(m.table_desc, 1) = '@'::text THEN '4. Дубликат'::text
                    WHEN "left"(m.table_desc, 1) = '>'::text THEN '3. Коррекция'::text
                    WHEN "left"(m.table_desc, 1) = '*'::text THEN '5. Удаление'::text
                    WHEN "left"(m.table_desc, 1) = '?'::text THEN '6. Уточнение'::text
                    ELSE '1. Описан'::text
                END AS table_state_dev_t
           FROM v_zom_calc_list c
             LEFT JOIN v_zom_table_fields f ON f.table_name::name = c.table_name::name
             LEFT JOIN v_zom_obj_comments m ON m.table_name = f.table_name::name AND m.column_name = f.column_name::name
             LEFT JOIN t_ds_name_list d ON c.table_name::name = d.table_name::name
        )
 SELECT g.group_description AS group_desc,
    v.group_table,
    v.table_cat,
    v.function_name,
    v.table_schema,
    v.table_name,
    v.table_desc,
    v.pos_num,
    v.column_origin,
    v.column_name,
    v.column_desc,
    v.data_type_group,
    v.data_type,
    v.has_zfr,
    v.has_ds_in_sv,
    v.has_table_desc,
    v.has_column_desc,
    v.col_state_dev,
    v.col_state_dev_t,
    v.table_state_dev,
    v.table_state_dev_t
   FROM t_view v
     LEFT JOIN public.z01_zom_group_table g ON g.group_table = v.group_table
  WHERE v.table_name IS NOT NULL AND "left"(v.table_desc, 1) <> '-'::text
  ORDER BY g.group_description, v.group_table, v.function_name, v.table_name, v.pos_num;
COMMENT ON VIEW public.v_zom IS 'Таблицы ОМ с полями и связанные функции БД';
COMMENT ON COLUMN public.v_zom.group_desc IS 'Описание группы таблиц';
COMMENT ON COLUMN public.v_zom.group_table IS 'Префикс группы таблиц';
COMMENT ON COLUMN public.v_zom.table_cat IS 'Категория таблицы: 01, 11';
COMMENT ON COLUMN public.v_zom.function_name IS 'Функция расчёта и обновления данных в таблицах';
COMMENT ON COLUMN public.v_zom.table_schema IS 'Схема таблицы';
COMMENT ON COLUMN public.v_zom.table_name IS 'Название таблицы';
COMMENT ON COLUMN public.v_zom.table_desc IS 'Описание таблицы';
COMMENT ON COLUMN public.v_zom.pos_num IS 'Номер столбца';
