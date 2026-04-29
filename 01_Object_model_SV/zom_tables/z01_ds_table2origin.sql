--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_table2origin (
	dsm_table_name_from text NULL, -- Название производной таблицы
	dsm_table_name_to text NULL, -- Название таблицы источника для производной таблицы
	dsm_table_type_to text NULL, -- Тип данных дочерней таблицы
	dsd_level int4 NULL, -- Позиция в последовательности происхождения таблиц
	dsd_path_name_type text NULL, -- Полный путь из названий датасетов с указанием их типа от последней производной таблицы на первичные таблицы
	dsd_path_name text NULL, -- Полный путь из названий датасетов от последней производной таблицы на первичные таблицы
	dsd_e1_name text NULL, -- Название таблицы на позиции 1
	dsd_e2_name text NULL, -- Название таблицы на позиции 2
	dsd_e3_name text NULL, -- Название таблицы на позиции 3
	dsd_e4_name text NULL, -- Название таблицы на позиции 4
	dsd_e5_name text NULL, -- Название таблицы на позиции 5
	dsd_e6_name text NULL, -- Название таблицы на позиции 6
	dsd_e7_name text NULL, -- Название таблицы на позиции 7
	dsd_e8_name text NULL, -- Название таблицы на позиции 8
	dsd_e9_name text NULL, -- Название таблицы на позиции 9
	dsd_e10_name text NULL, -- Название таблицы на позиции 10
	dsd_e11_name text NULL, -- Название таблицы на позиции 11
	dsd_e12_name text NULL, -- Название таблицы на позиции 12
	dsd_e13_name text NULL, -- Название таблицы на позиции 13
	dsd_e14_name text NULL, -- Название таблицы на позиции 14
	dsd_e15_name text NULL, -- Название таблицы на позиции 15
	dsd_e16_name text NULL, -- Название таблицы на позиции 16
	dsd_e17_name text NULL, -- Название таблицы на позиции 17
	dsd_e18_name text NULL, -- Название таблицы на позиции 18
	dsd_path_id text NULL, -- Полный путь из ID датасетов от последней производной таблицы на первичные таблицы
	dsd_e1_id text NULL, -- ID уровня 1 иерархии
	dsm_table_id_from text NULL, -- ID родительской таблицы
	dsm_table_id_to text NULL -- ID дочерней таблицы
);
COMMENT ON TABLE public.z01_ds_table2origin IS '>ОМ: объекты: датасеты: последовательность соединения таблиц до первичных таблиц';
COMMENT ON COLUMN public.z01_ds_table2origin.dsm_table_name_from IS 'Название производной таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsm_table_name_to IS 'Название таблицы источника для производной таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsm_table_type_to IS 'Тип данных дочерней таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_level IS 'Позиция в последовательности происхождения таблиц';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_path_name_type IS 'Полный путь из названий датасетов с указанием их типа от последней производной таблицы на первичные таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_path_name IS 'Полный путь из названий датасетов от последней производной таблицы на первичные таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e1_name IS 'Название таблицы на позиции 1';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e2_name IS 'Название таблицы на позиции 2';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e3_name IS 'Название таблицы на позиции 3';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e4_name IS 'Название таблицы на позиции 4';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e5_name IS 'Название таблицы на позиции 5';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e6_name IS 'Название таблицы на позиции 6';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e7_name IS 'Название таблицы на позиции 7';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e8_name IS 'Название таблицы на позиции 8';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e9_name IS 'Название таблицы на позиции 9';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e10_name IS 'Название таблицы на позиции 10';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e11_name IS 'Название таблицы на позиции 11';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e12_name IS 'Название таблицы на позиции 12';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e13_name IS 'Название таблицы на позиции 13';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e14_name IS 'Название таблицы на позиции 14';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e15_name IS 'Название таблицы на позиции 15';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e16_name IS 'Название таблицы на позиции 16';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e17_name IS 'Название таблицы на позиции 17';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e18_name IS 'Название таблицы на позиции 18';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_path_id IS 'Полный путь из ID датасетов от последней производной таблицы на первичные таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsd_e1_id IS 'ID уровня 1 иерархии';
COMMENT ON COLUMN public.z01_ds_table2origin.dsm_table_id_from IS 'ID родительской таблицы';
COMMENT ON COLUMN public.z01_ds_table2origin.dsm_table_id_to IS 'ID дочерней таблицы';

--
