--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_plugin_hist (
	phm_plugin_group text NULL, -- группа плагинов
	phm_plugin varchar(255) NULL, -- название плагина
	phd_is_delete int4 NULL, -- признак удаления
	phd_is_def_init_date int4 NULL, -- признак наличия даты установки
	phd_time_add_min date NULL, -- первая дата установки
	cnt_add int8 NULL, -- количество упоминаний
	phm_time_update_max date NULL, -- последняя дата обновления плагина
	cnt_update int8 NULL, -- количество обновлений плагина
	phm_time_delete_max date NULL, -- последняя дата удаления плагина
	cnt_delete int8 NULL, -- количество удалений плагина
	phd_plugin_age_days int4 NULL, -- возраст установки плагина, дней
	phd_last_update_days int4 NULL, -- давность обновления плагина, дней
	phd_last_delete_days int4 NULL -- давность удаления плагина, дней
);
COMMENT ON TABLE public.z01_plugin_hist IS 'ДП: система: плагины: состояние и статистика';
COMMENT ON COLUMN public.z01_plugin_hist.phm_plugin_group IS 'группа плагинов';
COMMENT ON COLUMN public.z01_plugin_hist.phm_plugin IS 'название плагина';
COMMENT ON COLUMN public.z01_plugin_hist.phd_is_delete IS 'признак удаления';
COMMENT ON COLUMN public.z01_plugin_hist.phd_is_def_init_date IS 'признак наличия даты установки';
COMMENT ON COLUMN public.z01_plugin_hist.phd_time_add_min IS 'первая дата установки';
COMMENT ON COLUMN public.z01_plugin_hist.cnt_add IS 'количество упоминаний';
COMMENT ON COLUMN public.z01_plugin_hist.phm_time_update_max IS 'последняя дата обновления плагина';
COMMENT ON COLUMN public.z01_plugin_hist.cnt_update IS 'количество обновлений плагина';
COMMENT ON COLUMN public.z01_plugin_hist.phm_time_delete_max IS 'последняя дата удаления плагина';
COMMENT ON COLUMN public.z01_plugin_hist.cnt_delete IS 'количество удалений плагина';
COMMENT ON COLUMN public.z01_plugin_hist.phd_plugin_age_days IS 'возраст установки плагина, дней';
COMMENT ON COLUMN public.z01_plugin_hist.phd_last_update_days IS 'давность обновления плагина, дней';
COMMENT ON COLUMN public.z01_plugin_hist.phd_last_delete_days IS 'давность удаления плагина, дней';

--
