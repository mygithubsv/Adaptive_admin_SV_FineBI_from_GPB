--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_prs_list (
	cat_params text NULL, -- Категория параметра (01 Config, 02 Parameters)
	subcat_params text NULL, -- Подкатегория параметра (часть слева от Config)
	last_par_name text NULL, -- Название параметра (последний уровень вложенности)
	"parameter" text NULL, -- Параметр полностью
	id varchar(1000) NULL, -- Значение параметра
	psm_id_p1 text NULL, -- Путь параметра ур.1
	psm_id_p2 text NULL, -- Путь параметра ур.2
	psm_id_p3 text NULL, -- Путь параметра ур.3
	psm_id_p4 text NULL, -- Путь параметра ур.4
	psm_id_p5 text NULL, -- Путь параметра ур.5
	psm_id_p6 text NULL, -- Путь параметра ур.6
	psm_id_p7 text NULL, -- Путь параметра ур.7
	psm_id_p8 text NULL, -- Путь параметра ур.8
	psm_id_p9 text NULL, -- Путь параметра ур.9
	psm_id_p10 text NULL -- Путь параметра ур.10
);
COMMENT ON TABLE public.z01_prs_list IS 'ОМ: параметры: параметры из fine_conf_entity с иерархией и группировкой';
COMMENT ON COLUMN public.z01_prs_list.cat_params IS 'Категория параметра (01 Config, 02 Parameters)';
COMMENT ON COLUMN public.z01_prs_list.subcat_params IS 'Подкатегория параметра (часть слева от Config)';
COMMENT ON COLUMN public.z01_prs_list.last_par_name IS 'Название параметра (последний уровень вложенности)';
COMMENT ON COLUMN public.z01_prs_list."parameter" IS 'Параметр полностью';
COMMENT ON COLUMN public.z01_prs_list.id IS 'Значение параметра';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p1 IS 'Путь параметра ур.1';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p2 IS 'Путь параметра ур.2';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p3 IS 'Путь параметра ур.3';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p4 IS 'Путь параметра ур.4';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p5 IS 'Путь параметра ур.5';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p6 IS 'Путь параметра ур.6';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p7 IS 'Путь параметра ур.7';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p8 IS 'Путь параметра ур.8';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p9 IS 'Путь параметра ур.9';
COMMENT ON COLUMN public.z01_prs_list.psm_id_p10 IS 'Путь параметра ур.10';

--
