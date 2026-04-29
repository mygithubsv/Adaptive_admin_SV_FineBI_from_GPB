--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_upd_task_list2 (
	upd_id text NULL, -- id обновления
	ec_type text NULL, -- ?
	timelist_frequency_type text NULL, -- тип периодичности
	timelist_frequency_value_unit jsonb NULL, -- единица периодичности
	timelist_cron text NULL, -- выражение CRON оригинал
	timelist_cron_uni text NULL, -- сгенерированное CRON выражение
	interval_hour int4 NULL, -- интервал обновления в часах
	timelist_frequency_value_space jsonb NULL, -- контент периодичности в json
	timelist_taskname text NULL, -- название задачи
	timelist_id text NULL, -- id задачи
	timelist_type jsonb NULL, -- тип задачи
	timelist_endtime timestamp NULL, -- дата окончания работы задачи
	timelist_starttime timestamp NULL, -- дата начала работы задачи
	"content" jsonb NULL -- контент в json
);
COMMENT ON TABLE public.z01_upd_task_list2 IS 'ОМ: обновления ДС: расписание обновления датасетов без иерархии (новая логика любой уровень)';
COMMENT ON COLUMN public.z01_upd_task_list2.upd_id IS 'id обновления';
COMMENT ON COLUMN public.z01_upd_task_list2.ec_type IS '?';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_frequency_type IS 'тип периодичности';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_frequency_value_unit IS 'единица периодичности';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_cron IS 'выражение CRON оригинал';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_cron_uni IS 'сгенерированное CRON выражение';
COMMENT ON COLUMN public.z01_upd_task_list2.interval_hour IS 'интервал обновления в часах';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_frequency_value_space IS 'контент периодичности в json';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_taskname IS 'название задачи';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_id IS 'id задачи';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_type IS 'тип задачи';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_endtime IS 'дата окончания работы задачи';
COMMENT ON COLUMN public.z01_upd_task_list2.timelist_starttime IS 'дата начала работы задачи';
COMMENT ON COLUMN public.z01_upd_task_list2."content" IS 'контент в json';

--
