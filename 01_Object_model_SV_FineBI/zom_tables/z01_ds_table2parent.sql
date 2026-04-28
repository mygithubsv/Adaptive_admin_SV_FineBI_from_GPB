--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_table2parent (
	dsm_engine_type text NULL, -- Тип подключения: Spider (S) или Direct (D)
	dsm_table_id_from varchar(32) NULL, -- ID родительской таблицы
	dsm_table_name_from text NULL, -- Название родительской таблицы
	dsm_table_id_to varchar(32) NULL, -- ID дочерней таблицы
	dsm_table_name_to text NULL, -- Название дочерней таблицы
	dsm_table_type_from text NULL, -- Тип родительской таблицы
	dsm_table_type_to text NULL -- Тип дочерней таблицы
);
COMMENT ON TABLE public.z01_ds_table2parent IS 'ОМ: объекты: датасеты: связь между двумя таблицами';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_engine_type IS 'Тип подключения: Spider (S) или Direct (D)';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_table_id_from IS 'ID родительской таблицы';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_table_name_from IS 'Название родительской таблицы';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_table_id_to IS 'ID дочерней таблицы';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_table_name_to IS 'Название дочерней таблицы';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_table_type_from IS 'Тип родительской таблицы';
COMMENT ON COLUMN public.z01_ds_table2parent.dsm_table_type_to IS 'Тип дочерней таблицы';

--
