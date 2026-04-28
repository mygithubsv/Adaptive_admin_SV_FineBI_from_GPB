--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_lnk_dsb2wid (
	lm_id_rep text NULL, -- ID дашборда из рабочей книги
	lm_id_wid text NULL -- ID виджета из рабочей книги
);
COMMENT ON TABLE public.z01_lnk_dsb2wid IS 'ОМ: объекты: дашборды: связь дашборды с компонентами';
COMMENT ON COLUMN public.z01_lnk_dsb2wid.lm_id_rep IS 'ID дашборда из рабочей книги';
COMMENT ON COLUMN public.z01_lnk_dsb2wid.lm_id_wid IS 'ID виджета из рабочей книги';

--
