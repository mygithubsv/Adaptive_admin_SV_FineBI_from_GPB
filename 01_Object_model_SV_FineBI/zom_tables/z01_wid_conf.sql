--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wid_conf (
	dsm_wid_id text NULL, -- id виджета (компонента)
	dsm_wid_model_text text NULL, -- обобщённое название модели виджета
	dsm_wid_model_text_uni text NULL, -- полное название модели виджета
	dsm_cnt_wid_view int4 NULL, -- количество выведенных полей
	dsm_wid_elems text NULL, -- число выведенных полей по измерениям
	dsm_cnt_wid_view_10000 int4 NULL, -- количество выведенных полей по измерению 1
	dsm_cnt_wid_view_20000 int4 NULL, -- количество выведенных полей по измерению 2
	dsm_cnt_wid_view_30000 int4 NULL, -- количество выведенных полей по измерению 3
	dsm_cnt_wid_measures int4 NULL, -- количество мер
	dsm_wid_measures text NULL, -- ?
	dsm_wid_type text NULL, -- код типа виджета
	dsm_wid_charttype text NULL, -- тип виджета
	dsm_wid_chart_type text NULL, -- тип графика
	dsm_wid_view_10000 text NULL, -- список данных по измерению 1
	dsm_wid_view_20000 text NULL, -- список данных по измерению 2
	dsm_wid_view_30000 text NULL, -- список данных по измерению 3
	dsd_json_conf jsonb NULL -- контент в json
);
COMMENT ON TABLE public.z01_wid_conf IS 'ОМ: объекты: виджеты: виджеты настройки';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_id IS 'id виджета (компонента)';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_model_text IS 'обобщённое название модели виджета';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_model_text_uni IS 'полное название модели виджета';
COMMENT ON COLUMN public.z01_wid_conf.dsm_cnt_wid_view IS 'количество выведенных полей';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_elems IS 'число выведенных полей по измерениям';
COMMENT ON COLUMN public.z01_wid_conf.dsm_cnt_wid_view_10000 IS 'количество выведенных полей по измерению 1';
COMMENT ON COLUMN public.z01_wid_conf.dsm_cnt_wid_view_20000 IS 'количество выведенных полей по измерению 2';
COMMENT ON COLUMN public.z01_wid_conf.dsm_cnt_wid_view_30000 IS 'количество выведенных полей по измерению 3';
COMMENT ON COLUMN public.z01_wid_conf.dsm_cnt_wid_measures IS 'количество мер';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_measures IS '?';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_type IS 'код типа виджета';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_charttype IS 'тип виджета';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_chart_type IS 'тип графика';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_view_10000 IS 'список данных по измерению 1';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_view_20000 IS 'список данных по измерению 2';
COMMENT ON COLUMN public.z01_wid_conf.dsm_wid_view_30000 IS 'список данных по измерению 3';
COMMENT ON COLUMN public.z01_wid_conf.dsd_json_conf IS 'контент в json';

--
