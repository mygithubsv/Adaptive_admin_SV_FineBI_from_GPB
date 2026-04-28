--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wbk_all (
	has_dpd text NULL, -- Категория отнесения УЗ на ССП
	dpd_path_ui text NULL, -- Полный путь ССП пользователя
	dpd_p1 text NULL, -- ССП ур.1 пользователя
	dpd_name varchar NULL, -- ССП пользователя
	owner_username varchar NULL, -- Текущий владелец, логин
	dpd_user_realname varchar(255) NULL, -- Текущий владелец, ФИО
	e1_name text NULL, -- Каталог песочницы ур.1
	e2_name text NULL, -- Каталог песочницы ур.2
	e3_name text NULL, -- Каталог песочницы ур.3
	e4_name text NULL, -- Каталог песочницы ур.4
	e5_name text NULL, -- Каталог песочницы ур.1
	e6_name text NULL, -- Каталог песочницы ур.1
	e7_name text NULL, -- Каталог песочницы ур.1
	e8_name text NULL, -- Каталог песочницы ур.1
	e9_name text NULL, -- Каталог песочницы ур.1
	e10_name text NULL, -- Каталог песочницы ур.1
	wbk_dir_path_name_type text NULL, -- Путь элемента рабочей книги с Root и через $
	ans_type text NULL, -- ?Тип рабочей книги
	ans_id text NULL, -- id рабочей книги
	ans_name text NULL, -- Название рабочей книги
	wbi_type text NULL, -- Тип элемента рабочей книги
	wbi_id text NULL, -- id элемента рабочей книги
	wbi_name text NULL, -- Название элемента рабочей книги
	wbi_path_name_full text NULL, -- Путь элемента рабочей книги с Root и через ->
	wbi_creator_id text NULL, -- id создателя элемента рабочей книги
	wbi_creator varchar(255) NULL, -- логин создателя элемента рабочей книги
	wbi_created timestamp NULL, -- время создания
	wbi_item_type text NULL, -- xТип элемента рабочей книги (дубль)
	dsm_ent_valid text NULL, -- признак валидности датасета SSDS
	dsd_is_corr int4 NULL -- признак корректной загрузки датасета из лога обновлений
);
COMMENT ON TABLE public.z01_wbk_all IS 'ОМ: объекты: рабочая книга: обобщённое представление';
COMMENT ON COLUMN public.z01_wbk_all.has_dpd IS 'Категория отнесения УЗ на ССП';
COMMENT ON COLUMN public.z01_wbk_all.dpd_path_ui IS 'Полный путь ССП пользователя';
COMMENT ON COLUMN public.z01_wbk_all.dpd_p1 IS 'ССП ур.1 пользователя';
COMMENT ON COLUMN public.z01_wbk_all.dpd_name IS 'ССП пользователя';
COMMENT ON COLUMN public.z01_wbk_all.owner_username IS 'Текущий владелец, логин';
COMMENT ON COLUMN public.z01_wbk_all.dpd_user_realname IS 'Текущий владелец, ФИО';
COMMENT ON COLUMN public.z01_wbk_all.e1_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.e2_name IS 'Каталог песочницы ур.2';
COMMENT ON COLUMN public.z01_wbk_all.e3_name IS 'Каталог песочницы ур.3';
COMMENT ON COLUMN public.z01_wbk_all.e4_name IS 'Каталог песочницы ур.4';
COMMENT ON COLUMN public.z01_wbk_all.e5_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.e6_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.e7_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.e8_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.e9_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.e10_name IS 'Каталог песочницы ур.1';
COMMENT ON COLUMN public.z01_wbk_all.wbk_dir_path_name_type IS 'Путь элемента рабочей книги с Root и через $';
COMMENT ON COLUMN public.z01_wbk_all.ans_type IS '?Тип рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.ans_id IS 'id рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.ans_name IS 'Название рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.wbi_type IS 'Тип элемента рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.wbi_id IS 'id элемента рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.wbi_name IS 'Название элемента рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.wbi_path_name_full IS 'Путь элемента рабочей книги с Root и через ->';
COMMENT ON COLUMN public.z01_wbk_all.wbi_creator_id IS 'id создателя элемента рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.wbi_creator IS 'логин создателя элемента рабочей книги';
COMMENT ON COLUMN public.z01_wbk_all.wbi_created IS 'время создания';
COMMENT ON COLUMN public.z01_wbk_all.wbi_item_type IS 'xТип элемента рабочей книги (дубль)';
COMMENT ON COLUMN public.z01_wbk_all.dsm_ent_valid IS 'признак валидности датасета SSDS';
COMMENT ON COLUMN public.z01_wbk_all.dsd_is_corr IS 'признак корректной загрузки датасета из лога обновлений';

--
