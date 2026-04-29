--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_fields_list (
	dsm_id text NULL, -- ID датасета
	dsm_pos_in_table int8 NULL, -- Номер столбца в таблице датасете
	dsm_field_id text NULL, -- ID поля датасета
	dsm_field_name text NULL, -- Название поля датасета
	dsm_field_name_src text NULL, -- Исходное название поля датасета
	dsm_field_is_rename int4 NULL, -- Признак: 1 - было переименование поля датасета
	dsm_field_type text NULL, -- Тип поля датасета
	dsm_field_type_src text NULL, -- Исходный тип поля датасета
	dsm_field_is_convert int4 NULL, -- Признак: 1 - было конвертирование типов
	dsm_field_fieldgrouptype text NULL, -- ? Тип группировки поля
	dsm_field_usable text NULL, -- > Признак: 1 - используется
	dsm_field_datarowfieldmeta text NULL, -- ? Метаданные только для полей DIRECT
	dsm_field_jdbctype text NULL, -- ? Метаданные типа jdbc
	dsm_field_columnsize text NULL, -- ? Метаданные размер столбца
	dsm_field_columnscale text NULL -- ? Метаданные масштаб
);
COMMENT ON TABLE public.z01_ds_fields_list IS 'ОМ: объекты: датасеты: поля датасетов';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_pos_in_table IS 'Номер столбца в таблице датасете';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_id IS 'ID поля датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_name IS 'Название поля датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_name_src IS 'Исходное название поля датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_is_rename IS 'Признак: 1 - было переименование поля датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_type IS 'Тип поля датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_type_src IS 'Исходный тип поля датасета';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_is_convert IS 'Признак: 1 - было конвертирование типов';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_fieldgrouptype IS '? Тип группировки поля';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_usable IS '> Признак: 1 - используется';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_datarowfieldmeta IS '? Метаданные только для полей DIRECT';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_jdbctype IS '? Метаданные типа jdbc';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_columnsize IS '? Метаданные размер столбца';
COMMENT ON COLUMN public.z01_ds_fields_list.dsm_field_columnscale IS '? Метаданные масштаб';

--
