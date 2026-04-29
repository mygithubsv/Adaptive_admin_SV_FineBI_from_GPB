--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_upd_stats (
	dsm_id varchar(255) NULL, -- ID датасета
	dsm_load_type text NULL, -- Тип датасета (ETL,BASE,Relation)
	dsd_is_corr int4 NULL, -- Признак: 1 - корректный по последнему обновлению
	dsd_age_success_cat int4 NULL, -- Категория давности обновления
	dsd_err_cat int4 NULL, -- Категорировние ошибочных
	dsd_cnt_wrong int8 NULL, -- Число незавершенных загрузок
	dsd_cnt_upd int8 NULL, -- Число завершенных успешно загрузок
	dsd_perc_wrong numeric NULL, -- Процент незавершённых загрузок от всего числа обновлений
	dsd_last_success timestamp NULL, -- ?Дата старта последнего успешного обновления
	dsd_last_wrong timestamp NULL, -- ?Дата старта последнего незавершённого обновления
	dsd_delta_hours_scs numeric NULL -- Давность обновления в часах
);
COMMENT ON TABLE public.z01_ds_upd_stats IS 'ОМ: объекты: датасеты: статистика обновлений датасетов';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsm_load_type IS 'Тип датасета (ETL,BASE,Relation)';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_is_corr IS 'Признак: 1 - корректный по последнему обновлению';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_age_success_cat IS 'Категория давности обновления';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_err_cat IS 'Категорировние ошибочных';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_cnt_wrong IS 'Число незавершенных загрузок';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_cnt_upd IS 'Число завершенных успешно загрузок';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_perc_wrong IS 'Процент незавершённых загрузок от всего числа обновлений';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_last_success IS '?Дата старта последнего успешного обновления';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_last_wrong IS '?Дата старта последнего незавершённого обновления';
COMMENT ON COLUMN public.z01_ds_upd_stats.dsd_delta_hours_scs IS 'Давность обновления в часах';

--
