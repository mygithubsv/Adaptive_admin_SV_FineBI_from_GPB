--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wid_all (
	wdm_id text NULL, -- id виджета
	wdm_name text NULL, -- название виджета
	wdm_creator_id text NULL, -- id создателя
	wdm_creator varchar(255) NULL, -- создатель
	wdm_init_time timestamp NULL, -- создан
	wdm_update_time timestamp NULL, -- редактирован
	dsm_wid_model_text text NULL, -- Основной тип (Таблица или визуал)
	dsm_wid_model_text_uni text NULL, -- Дополнительный тип
	dsm_cnt_wid_view int4 NULL, -- всего элементов во всех блоках настроек
	dsm_wid_elems text NULL, -- детальная строка по количеству элементов всех блоков настроек
	dsm_cnt_wid_view_10000 int4 NULL, -- количество элементов в блоке настроек 1
	dsm_cnt_wid_view_20000 int4 NULL, -- количество элементов в блоке настроек 2
	dsm_cnt_wid_view_30000 int4 NULL, -- количество элементов в блоке настроек 3
	dsm_cnt_wid_measures int4 NULL, -- ?количество элементов в блоке мер
	dsm_wid_measures text NULL, -- ?список элементов в блоке мер
	dsm_wid_type text NULL, -- id типа виджета
	dsm_wid_charttype text NULL, -- тип виджета
	dsm_wid_chart_type text NULL, -- ?всегда пусто?
	dsm_wid_view_10000 text NULL, -- список id элементов в блоке настроек 1
	dsm_wid_view_20000 text NULL, -- список id элементов в блоке настроек 2
	dsm_wid_view_30000 text NULL, -- список id элементов в блоке настроек 3
	dsd_json_conf jsonb NULL -- декодированный json с конфигурацией
);
COMMENT ON TABLE public.z01_wid_all IS 'ОМ: объекты: виджеты: обобщённое представление';
COMMENT ON COLUMN public.z01_wid_all.wdm_id IS 'id виджета';
COMMENT ON COLUMN public.z01_wid_all.wdm_name IS 'название виджета';
COMMENT ON COLUMN public.z01_wid_all.wdm_creator_id IS 'id создателя';
COMMENT ON COLUMN public.z01_wid_all.wdm_creator IS 'создатель';
COMMENT ON COLUMN public.z01_wid_all.wdm_init_time IS 'создан';
COMMENT ON COLUMN public.z01_wid_all.wdm_update_time IS 'редактирован';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_model_text IS 'Основной тип (Таблица или визуал)';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_model_text_uni IS 'Дополнительный тип';
COMMENT ON COLUMN public.z01_wid_all.dsm_cnt_wid_view IS 'всего элементов во всех блоках настроек';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_elems IS 'детальная строка по количеству элементов всех блоков настроек';
COMMENT ON COLUMN public.z01_wid_all.dsm_cnt_wid_view_10000 IS 'количество элементов в блоке настроек 1';
COMMENT ON COLUMN public.z01_wid_all.dsm_cnt_wid_view_20000 IS 'количество элементов в блоке настроек 2';
COMMENT ON COLUMN public.z01_wid_all.dsm_cnt_wid_view_30000 IS 'количество элементов в блоке настроек 3';
COMMENT ON COLUMN public.z01_wid_all.dsm_cnt_wid_measures IS '?количество элементов в блоке мер';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_measures IS '?список элементов в блоке мер';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_type IS 'id типа виджета';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_charttype IS 'тип виджета';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_chart_type IS '?всегда пусто?';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_view_10000 IS 'список id элементов в блоке настроек 1';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_view_20000 IS 'список id элементов в блоке настроек 2';
COMMENT ON COLUMN public.z01_wid_all.dsm_wid_view_30000 IS 'список id элементов в блоке настроек 3';
COMMENT ON COLUMN public.z01_wid_all.dsd_json_conf IS 'декодированный json с конфигурацией';

--
