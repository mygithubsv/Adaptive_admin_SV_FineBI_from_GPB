--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_con_hist (
	chm_data_connection varchar(255) NULL, -- название подключения
	chd_is_delete int4 NULL, -- флаг удален = 1
	chd_is_def_init_date int4 NULL, -- флаг наличие даты создания
	chd_time_add_min date NULL, -- первая дата появления по логам
	cnt_add int8 NULL, -- количество добавлений
	chm_time_update_max date NULL, -- последнее добавление
	cnt_update int8 NULL, -- количество обновлений
	chm_time_delete_max date NULL, -- последнее обновление
	cnt_delete int8 NULL, -- количество удалений
	chd_conn_age_days int4 NULL, -- возраст подключения в днях
	chd_last_update_days int4 NULL, -- последнее обновление, дней назад
	chd_last_delete_days int4 NULL -- последнее удаление, дней назад
);
COMMENT ON TABLE public.z01_con_hist IS 'ОМ: объекты: подключения: даты изменений';
COMMENT ON COLUMN public.z01_con_hist.chm_data_connection IS 'название подключения';
COMMENT ON COLUMN public.z01_con_hist.chd_is_delete IS 'флаг удален = 1';
COMMENT ON COLUMN public.z01_con_hist.chd_is_def_init_date IS 'флаг наличие даты создания';
COMMENT ON COLUMN public.z01_con_hist.chd_time_add_min IS 'первая дата появления по логам';
COMMENT ON COLUMN public.z01_con_hist.cnt_add IS 'количество добавлений';
COMMENT ON COLUMN public.z01_con_hist.chm_time_update_max IS 'последнее добавление';
COMMENT ON COLUMN public.z01_con_hist.cnt_update IS 'количество обновлений';
COMMENT ON COLUMN public.z01_con_hist.chm_time_delete_max IS 'последнее обновление';
COMMENT ON COLUMN public.z01_con_hist.cnt_delete IS 'количество удалений';
COMMENT ON COLUMN public.z01_con_hist.chd_conn_age_days IS 'возраст подключения в днях';
COMMENT ON COLUMN public.z01_con_hist.chd_last_update_days IS 'последнее обновление, дней назад';
COMMENT ON COLUMN public.z01_con_hist.chd_last_delete_days IS 'последнее удаление, дней назад';

--
