--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_cache_table (
	dsd_node_name varchar(50) NULL, -- MAC-адрес ВМ с ПО
	dsd_cache_table_prefix text NULL, -- Префикс таблиц: T - основные таблицы
	dsd_ds_found text NULL, -- Признак текст: датасет найден в UI
	dsd_is_ds_found int4 NULL, -- Признак: 1 - датасет найден в UI
	dsm_id text NULL, -- ID датасета
	dsm_name text NULL, -- Название датасета
	dsd_cache_table_name varchar(255) NULL, -- Название каталога кэша на диске ВМ с ПО
	dsd_exist_nodes varchar(65536) NULL -- Перечень нод с размещенным кэшем
);
COMMENT ON TABLE public.z01_ds_cache_table IS 'ОМ: объекты: датасеты: сравнение кэша данных датасетов со списком в UI';
COMMENT ON COLUMN public.z01_ds_cache_table.dsd_node_name IS 'MAC-адрес ВМ с ПО';
COMMENT ON COLUMN public.z01_ds_cache_table.dsd_cache_table_prefix IS 'Префикс таблиц: T - основные таблицы';
COMMENT ON COLUMN public.z01_ds_cache_table.dsd_ds_found IS 'Признак текст: датасет найден в UI';
COMMENT ON COLUMN public.z01_ds_cache_table.dsd_is_ds_found IS 'Признак: 1 - датасет найден в UI';
COMMENT ON COLUMN public.z01_ds_cache_table.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_cache_table.dsm_name IS 'Название датасета';
COMMENT ON COLUMN public.z01_ds_cache_table.dsd_cache_table_name IS 'Название каталога кэша на диске ВМ с ПО';
COMMENT ON COLUMN public.z01_ds_cache_table.dsd_exist_nodes IS 'Перечень нод с размещенным кэшем';

--
