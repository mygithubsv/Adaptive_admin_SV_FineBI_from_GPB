--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_upd_task_list (
	id text NULL, -- ID сущности (каталог или датасет)
	timelist_frequency_type text NULL, -- Частота запуска
	timelist_frequency_value_unit jsonb NULL, -- Метаданные частоты запуска
	timelist_cron text NULL, -- Расписание cron
	timelist_cron_uni text NULL, -- Универсальное расписание cron
	interval_hour int4 NULL, -- Интервал в часах
	timelist_frequency_value_space jsonb NULL, -- ?
	timelist_taskname text NULL, -- Название задачи обновления
	timelist_taskname_clear text NULL, -- Название задачи обновления (без UpdateTask)
	timelist_type jsonb NULL, -- Тип сущности (1 - датасет, 0 - каталог)
	timelist_endtime timestamp NULL, -- Окончание расписания обновления
	timelist_starttime timestamp NULL, -- Начало расписания обновления
	"content" jsonb NULL -- ?
);
COMMENT ON TABLE public.z01_upd_task_list IS '@ОМ: обновления ДС: расписание обновления датасетов без иерархии (старая логика только верхнего каталога)';
COMMENT ON COLUMN public.z01_upd_task_list.id IS 'ID сущности (каталог или датасет)';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_frequency_type IS 'Частота запуска';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_frequency_value_unit IS 'Метаданные частоты запуска';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_cron IS 'Расписание cron';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_cron_uni IS 'Универсальное расписание cron';
COMMENT ON COLUMN public.z01_upd_task_list.interval_hour IS 'Интервал в часах';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_frequency_value_space IS '?';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_taskname IS 'Название задачи обновления';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_taskname_clear IS 'Название задачи обновления (без UpdateTask)';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_type IS 'Тип сущности (1 - датасет, 0 - каталог)';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_endtime IS 'Окончание расписания обновления';
COMMENT ON COLUMN public.z01_upd_task_list.timelist_starttime IS 'Начало расписания обновления';
COMMENT ON COLUMN public.z01_upd_task_list."content" IS '?';

--
