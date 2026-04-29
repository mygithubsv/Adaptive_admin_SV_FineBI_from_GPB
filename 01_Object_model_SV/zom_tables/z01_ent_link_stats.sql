--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ent_link_stats (
	entity_id text NULL, -- id сущность (дашборд, виджет, датасет, подключение)
	cnt_rep int8 NULL, -- количество дашбордов
	cnt_wid int8 NULL, -- количество виджетов
	cnt_ds_all int8 NULL, -- количество датасетов, указанных для виджетов
	cnt_ds_descr int8 NULL, -- количество фактически существующих датасетов с метаданными
	cnt_ds_origin int8 NULL, -- количество датасетов, найденных с путями
	cnt_ds_path int8 NULL, -- количество уникальных origin
	cnt_con int8 NULL, -- количество подключений
	par_val int4 NULL, -- id типа сущности (1 - дашборд, 2 - виджет, 3 - датасет, 4 - подключение)
	ent_type text NULL -- тип сущности (дашборд, виджет, датасет, подключение)
);
COMMENT ON TABLE public.z01_ent_link_stats IS 'ОМ: объекты: статистика связей: дашборд, виджет, датасет, подключение';
COMMENT ON COLUMN public.z01_ent_link_stats.entity_id IS 'id сущность (дашборд, виджет, датасет, подключение)';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_rep IS 'количество дашбордов';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_wid IS 'количество виджетов';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_ds_all IS 'количество датасетов, указанных для виджетов';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_ds_descr IS 'количество фактически существующих датасетов с метаданными';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_ds_origin IS 'количество датасетов, найденных с путями';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_ds_path IS 'количество уникальных origin';
COMMENT ON COLUMN public.z01_ent_link_stats.cnt_con IS 'количество подключений';
COMMENT ON COLUMN public.z01_ent_link_stats.par_val IS 'id типа сущности (1 - дашборд, 2 - виджет, 3 - датасет, 4 - подключение)';
COMMENT ON COLUMN public.z01_ent_link_stats.ent_type IS 'тип сущности (дашборд, виджет, датасет, подключение)';

--
