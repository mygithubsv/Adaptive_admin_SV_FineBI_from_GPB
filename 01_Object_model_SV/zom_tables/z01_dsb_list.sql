--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_dsb_list (
	dm_dash_name text NULL, -- Название дашборда
	dd_path_fine_bi text NULL, -- Путь в коллекции к дашборду
	dd_path_1 text NULL, -- Путь уровня 1
	dd_path_2 text NULL, -- Путь уровня 2
	dd_path_3 text NULL, -- Путь уровня 3
	dd_path_4 text NULL, -- Путь уровня 4
	dd_path_5 text NULL, -- Путь уровня 5
	dd_path_6 text NULL, -- Путь уровня 6
	dd_path_7 text NULL, -- Путь уровня 7
	dd_path_8 text NULL, -- Путь уровня 8
	dd_path_9 text NULL, -- Путь уровня 9
	dd_dev_name_full varchar NULL, -- Владелец дашборда
	dd_dev_login varchar NULL, -- УЗ владелец дашборда
	dd_path_dev_directory text NULL, -- Путь в песочнице пользователя к дашборду
	dm_createddate timestamp NULL, -- Дата создания дашборда
	dm_updatedate timestamp NULL, -- Дата изменения дашборда
	dm_publish_name text NULL, -- Модератор публикации
	dm_publish_login text NULL, -- УЗ модератора публикации
	dm_dash_link text NULL, -- Ссылка на дашборд
	dd_rn_dash_group int4 NULL, -- > нумерация каталога коллекции 1 уровня
	dd_rn_dash int4 NULL, -- > сквозная нумерация каталога коллекции 1 уровня
	dm_dash_id text NULL, -- ID дашборда
	dm_is_public_link int4 NULL, -- > признак публичной ссылки для дашборда
	dm_is_publish int4 NULL, -- Признак: 1 - Опубликован
	dm_expandid_a text NULL -- Точка публикации в каталоге коллекции
);
COMMENT ON TABLE public.z01_dsb_list IS 'ОМ: объекты: дашборды: список';
COMMENT ON COLUMN public.z01_dsb_list.dm_dash_name IS 'Название дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_fine_bi IS 'Путь в коллекции к дашборду';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_1 IS 'Путь уровня 1';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_2 IS 'Путь уровня 2';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_3 IS 'Путь уровня 3';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_4 IS 'Путь уровня 4';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_5 IS 'Путь уровня 5';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_6 IS 'Путь уровня 6';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_7 IS 'Путь уровня 7';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_8 IS 'Путь уровня 8';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_9 IS 'Путь уровня 9';
COMMENT ON COLUMN public.z01_dsb_list.dd_dev_name_full IS 'Владелец дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dd_dev_login IS 'УЗ владелец дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dd_path_dev_directory IS 'Путь в песочнице пользователя к дашборду';
COMMENT ON COLUMN public.z01_dsb_list.dm_createddate IS 'Дата создания дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dm_updatedate IS 'Дата изменения дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dm_publish_name IS 'Модератор публикации';
COMMENT ON COLUMN public.z01_dsb_list.dm_publish_login IS 'УЗ модератора публикации';
COMMENT ON COLUMN public.z01_dsb_list.dm_dash_link IS 'Ссылка на дашборд';
COMMENT ON COLUMN public.z01_dsb_list.dd_rn_dash_group IS '> нумерация каталога коллекции 1 уровня';
COMMENT ON COLUMN public.z01_dsb_list.dd_rn_dash IS '> сквозная нумерация каталога коллекции 1 уровня';
COMMENT ON COLUMN public.z01_dsb_list.dm_dash_id IS 'ID дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dm_is_public_link IS '> признак публичной ссылки для дашборда';
COMMENT ON COLUMN public.z01_dsb_list.dm_is_publish IS 'Признак: 1 - Опубликован';
COMMENT ON COLUMN public.z01_dsb_list.dm_expandid_a IS 'Точка публикации в каталоге коллекции';

--
