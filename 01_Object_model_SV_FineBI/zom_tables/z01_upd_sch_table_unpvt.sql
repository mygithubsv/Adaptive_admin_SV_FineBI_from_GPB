--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_upd_sch_table_unpvt (
	"name" text NULL, -- Название датасета + ID
	dir_timelist_cron_uni text NULL, -- Расписание обновления каталога датасета
	timelist_cron_uni text NULL, -- Расписание обновления датасета
	ex_hour int8 NULL, -- Метка часа
	t_hour int4 NULL -- Признак: 1 - расписание активно в час метки
);
COMMENT ON TABLE public.z01_upd_sch_table_unpvt IS '@ОМ: обновления ДС: расписание обновления датасетов с иерархией в формате "час столбец"';
COMMENT ON COLUMN public.z01_upd_sch_table_unpvt."name" IS 'Название датасета + ID';
COMMENT ON COLUMN public.z01_upd_sch_table_unpvt.dir_timelist_cron_uni IS 'Расписание обновления каталога датасета';
COMMENT ON COLUMN public.z01_upd_sch_table_unpvt.timelist_cron_uni IS 'Расписание обновления датасета';
COMMENT ON COLUMN public.z01_upd_sch_table_unpvt.ex_hour IS 'Метка часа';
COMMENT ON COLUMN public.z01_upd_sch_table_unpvt.t_hour IS 'Признак: 1 - расписание активно в час метки';

--
