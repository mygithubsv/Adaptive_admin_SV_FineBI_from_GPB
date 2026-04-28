--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_upd_sch_ds_cron_parse (
	timelist_cron_uni text NULL, -- универсальное представление всех расписаний в cron
	cron_hour text NULL, -- настройка часа из расписания cron
	h_0 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_1 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_2 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_3 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_4 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_5 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_6 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_7 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_8 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_9 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_10 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_11 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_12 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_13 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_14 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_15 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_16 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_17 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_18 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_19 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_20 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_21 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_22 int4 NULL, -- Отнесение часа из расписания cron на столбец выделенного часа
	h_23 int4 NULL -- Отнесение часа из расписания cron на столбец выделенного часа
);
COMMENT ON TABLE public.z01_upd_sch_ds_cron_parse IS '>ОМ: обновления ДС: Уникальные расписания обновления cron в универсальном формате';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.timelist_cron_uni IS 'универсальное представление всех расписаний в cron';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.cron_hour IS 'настройка часа из расписания cron';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_0 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_1 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_2 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_3 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_4 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_5 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_6 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_7 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_8 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_9 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_10 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_11 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_12 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_13 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_14 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_15 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_16 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_17 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_18 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_19 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_20 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_21 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_22 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_ds_cron_parse.h_23 IS 'Отнесение часа из расписания cron на столбец выделенного часа';

--
