--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_upd_sch_table_pvt (
	"name" text NULL, -- название датасета + ID
	dir_timelist_cron_uni text NULL, -- Расписание обновления каталога датасета
	timelist_cron_uni text NULL, -- Расписание обновления датасета (индивидуальное)
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
COMMENT ON TABLE public.z01_upd_sch_table_pvt IS '@ОМ: обновления ДС: расписание обновления датасетов с иерархией в формате "час строка"';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt."name" IS 'название датасета + ID';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.dir_timelist_cron_uni IS 'Расписание обновления каталога датасета';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.timelist_cron_uni IS 'Расписание обновления датасета (индивидуальное)';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_0 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_1 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_2 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_3 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_4 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_5 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_6 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_7 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_8 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_9 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_10 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_11 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_12 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_13 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_14 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_15 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_16 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_17 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_18 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_19 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_20 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_21 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_22 IS 'Отнесение часа из расписания cron на столбец выделенного часа';
COMMENT ON COLUMN public.z01_upd_sch_table_pvt.h_23 IS 'Отнесение часа из расписания cron на столбец выделенного часа';

--
