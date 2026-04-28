--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_conf (
	dsm_id text NULL, -- ID датасета
	dsm_type text NULL, -- Тип датасета
	dsm_conn_name text NULL, -- Подключение датасета
	dsm_tablename text NULL, -- Название датасета
	dsm_db_tablename text NULL, -- Название таблицы источника датасета в БД
	dsm_file_name text NULL, -- Название таблицы источника датасета для Excel
	dsm_origin_source text NULL, -- Название таблицы источника датасета для Server Dataset
	dsm_ecf_content text NULL, -- Свойства датасета
	dsm_sql text NULL, -- SQL код датасета
	dsd_sql_preview text NULL, -- Preview SQL кода датасета (сжатие полей между select и from)
	dsd_len_sqltext int4 NULL -- Длина SQL кода датасета
);
COMMENT ON TABLE public.z01_ds_conf IS 'ОМ: объекты: датасеты: атрибуты';
COMMENT ON COLUMN public.z01_ds_conf.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_conf.dsm_type IS 'Тип датасета';
COMMENT ON COLUMN public.z01_ds_conf.dsm_conn_name IS 'Подключение датасета';
COMMENT ON COLUMN public.z01_ds_conf.dsm_tablename IS 'Название датасета';
COMMENT ON COLUMN public.z01_ds_conf.dsm_db_tablename IS 'Название таблицы источника датасета в БД';
COMMENT ON COLUMN public.z01_ds_conf.dsm_file_name IS 'Название таблицы источника датасета для Excel';
COMMENT ON COLUMN public.z01_ds_conf.dsm_origin_source IS 'Название таблицы источника датасета для Server Dataset';
COMMENT ON COLUMN public.z01_ds_conf.dsm_ecf_content IS 'Свойства датасета';
COMMENT ON COLUMN public.z01_ds_conf.dsm_sql IS 'SQL код датасета';
COMMENT ON COLUMN public.z01_ds_conf.dsd_sql_preview IS 'Preview SQL кода датасета (сжатие полей между select и from)';
COMMENT ON COLUMN public.z01_ds_conf.dsd_len_sqltext IS 'Длина SQL кода датасета';

--
