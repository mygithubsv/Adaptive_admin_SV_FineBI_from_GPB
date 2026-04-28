--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_lnk_wid2ds (
	lm_id_wid text NULL, -- ID виджета из рабочей книги
	lm_id_tab text NULL -- ID датасета источника данных для виджета из рабочей книги
);
COMMENT ON TABLE public.z01_lnk_wid2ds IS 'ОМ: объекты: дашборды: связь компонентов дашбордов с источниками';
COMMENT ON COLUMN public.z01_lnk_wid2ds.lm_id_wid IS 'ID виджета из рабочей книги';
COMMENT ON COLUMN public.z01_lnk_wid2ds.lm_id_tab IS 'ID датасета источника данных для виджета из рабочей книги';

--
