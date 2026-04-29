--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_upd_sch_table (
	task_lvl_dir int4 NULL, -- Уровень иерархии Public Data
	dsm_id text NULL, -- ID датасета
	dsm_name_uniq text NULL, -- Название датасета (уникальное)
	dsd_path_ds text NULL, -- Путь к датасету Public Data
	dsm_level int4 NULL, -- @Уровень иерархии Public Data
	dsd_e1_name text NULL, -- Элемент иерархии уровня 1
	dsd_e1_pkg_ds_id text NULL, -- ID элемента иерархии уровня 1
	dsd_e2_name text NULL, -- Элемент иерархии уровня 2
	dsd_e2_pkg_ds_id text NULL, -- ID элемента иерархии уровня 2
	dsd_e3_name text NULL, -- Элемент иерархии уровня 3
	dsd_e3_pkg_ds_id text NULL, -- ID элемента иерархии уровня 3
	dsd_e4_name text NULL, -- Элемент иерархии уровня 4
	dsd_e4_pkg_ds_id text NULL, -- ID элемента иерархии уровня 4
	dsd_e5_name text NULL, -- Элемент иерархии уровня 5
	dsd_e5_pkg_ds_id text NULL, -- ID элемента иерархии уровня 5
	dsm_name text NULL, -- Название датасета
	dsm_config_created timestamp NULL, -- Создание датасета
	dsm_driver_type text NULL, -- Тип датасета
	dsm_db_name text NULL, -- Название таблицы датасета в БД
	dsm_con_name text NULL, -- Подключение к БД
	dsm_creator_id text NULL, -- ID создателя датасета
	dsm_creator_name varchar(255) NULL, -- Создатель датасета
	dir_id text NULL, -- ID каталога
	dir_timelist_taskname text NULL, -- Название задачи обновления каталога
	dir_timelist_taskname_clear text NULL, -- Название задачи обновления каталога (без UpdateTask)
	dir_timelist_frequency_type text NULL, -- Частота задачи обновления каталога
	dir_timelist_frequency_value_unit jsonb NULL, -- Настройки частоты задачи обновления каталога
	dir_interval_hour int4 NULL, -- Интервал повторения обновления для каталога, часы
	dir_timelist_frequency_value_space text NULL, -- ?
	dir_timelist_cron_uni text NULL, -- Универсальное выражение cron для каталога
	dir_timelist_type text NULL, -- ?
	dir_timelist_endtime timestamp NULL, -- Окончание задачи обновления каталога
	dir_timelist_starttime timestamp NULL, -- Старт задачи обновления каталога
	dir_content text NULL, -- Метаданные обновления каталога (json)
	id text NULL, -- ID датасета
	timelist_taskname text NULL, -- Название задачи обновления датасета
	timelist_taskname_clear text NULL, -- Название задачи обновления датасета (без UpdateTask)
	timelist_frequency_type text NULL, -- Частота задачи обновления датасета
	timelist_frequency_value_unit text NULL, -- Настройки частоты задачи обновления датасета
	interval_hour int4 NULL, -- Интервал повторения задачи обновления для датасета, часы
	timelist_frequency_value_space text NULL, -- ?
	timelist_cron text NULL, -- Выражение cron для датасета
	timelist_cron_uni text NULL, -- Универсальное выражение cron для датасета
	timelist_type text NULL, -- ?
	timelist_endtime timestamp NULL, -- Окончание задачи обновления датасета
	timelist_starttime timestamp NULL, -- Старт задачи обновления датасета
	"content" text NULL -- Метаданные обновления датасета (json)
);
COMMENT ON TABLE public.z01_upd_sch_table IS '>ОМ: обновления ДС: расписание обновления датасетов с иерархией каталогов';
COMMENT ON COLUMN public.z01_upd_sch_table.task_lvl_dir IS 'Уровень иерархии Public Data';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_name_uniq IS 'Название датасета (уникальное)';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_path_ds IS 'Путь к датасету Public Data';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_level IS '@Уровень иерархии Public Data';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e1_name IS 'Элемент иерархии уровня 1';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e1_pkg_ds_id IS 'ID элемента иерархии уровня 1';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e2_name IS 'Элемент иерархии уровня 2';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e2_pkg_ds_id IS 'ID элемента иерархии уровня 2';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e3_name IS 'Элемент иерархии уровня 3';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e3_pkg_ds_id IS 'ID элемента иерархии уровня 3';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e4_name IS 'Элемент иерархии уровня 4';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e4_pkg_ds_id IS 'ID элемента иерархии уровня 4';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e5_name IS 'Элемент иерархии уровня 5';
COMMENT ON COLUMN public.z01_upd_sch_table.dsd_e5_pkg_ds_id IS 'ID элемента иерархии уровня 5';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_name IS 'Название датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_config_created IS 'Создание датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_driver_type IS 'Тип датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_db_name IS 'Название таблицы датасета в БД';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_con_name IS 'Подключение к БД';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_creator_id IS 'ID создателя датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.dsm_creator_name IS 'Создатель датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_id IS 'ID каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_taskname IS 'Название задачи обновления каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_taskname_clear IS 'Название задачи обновления каталога (без UpdateTask)';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_frequency_type IS 'Частота задачи обновления каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_frequency_value_unit IS 'Настройки частоты задачи обновления каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_interval_hour IS 'Интервал повторения обновления для каталога, часы';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_frequency_value_space IS '?';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_cron_uni IS 'Универсальное выражение cron для каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_type IS '?';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_endtime IS 'Окончание задачи обновления каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_timelist_starttime IS 'Старт задачи обновления каталога';
COMMENT ON COLUMN public.z01_upd_sch_table.dir_content IS 'Метаданные обновления каталога (json)';
COMMENT ON COLUMN public.z01_upd_sch_table.id IS 'ID датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_taskname IS 'Название задачи обновления датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_taskname_clear IS 'Название задачи обновления датасета (без UpdateTask)';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_frequency_type IS 'Частота задачи обновления датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_frequency_value_unit IS 'Настройки частоты задачи обновления датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.interval_hour IS 'Интервал повторения задачи обновления для датасета, часы';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_frequency_value_space IS '?';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_cron IS 'Выражение cron для датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_cron_uni IS 'Универсальное выражение cron для датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_type IS '?';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_endtime IS 'Окончание задачи обновления датасета';
COMMENT ON COLUMN public.z01_upd_sch_table.timelist_starttime IS 'Старт задачи обновления датасета';
COMMENT ON COLUMN public.z01_upd_sch_table."content" IS 'Метаданные обновления датасета (json)';

--
