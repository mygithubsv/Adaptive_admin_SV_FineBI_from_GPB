--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE VIEW public.v_zom_table_fields
AS SELECT table_schema,
    table_name,
    ordinal_position AS pos_num,
    column_name,
        CASE
            WHEN data_type::text = 'timestamp without time zone'::text THEN 'timestamp'::character varying
            WHEN data_type::text = 'character varying'::text THEN 'varchar'::character varying
            ELSE data_type::character varying
        END AS data_type
   FROM information_schema.columns
  WHERE table_schema::name = 'public'::name AND ("left"(table_name::text, 3) = ANY (ARRAY['z01'::text, 'z11'::text]))
  ORDER BY table_schema, table_name, ordinal_position;
COMMENT ON VIEW public.v_zom_table_fields IS 'Список полей таблиц ОМ';
COMMENT ON COLUMN public.v_zom_table_fields.table_schema IS 'название схемы';
COMMENT ON COLUMN public.v_zom_table_fields.table_name IS 'название таблицы';
COMMENT ON COLUMN public.v_zom_table_fields.pos_num IS 'номер столбца в таблице';
COMMENT ON COLUMN public.v_zom_table_fields.column_name IS 'название столбца';
COMMENT ON COLUMN public.v_zom_table_fields.data_type IS 'тип данных столбца';
