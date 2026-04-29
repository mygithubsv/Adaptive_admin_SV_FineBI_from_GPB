--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wbk_hrh_table (
	owner_username varchar NULL, -- пространство пользователя для РК
	id_subj text NULL, -- id сущности песочницы
	name_subj text NULL, -- название сущности песочницы
	creator text NULL, -- id создателя
	creator_subj varchar(255) NULL, -- логин создателя
	configcreatedtime_subj timestamp NULL, -- время создания
	ftype_subj int4 NULL, -- id типа сущности песочницы
	wbk_item_type_t text NULL, -- тип сущности песочницы, текст
	parent_id text NULL -- id родительской записи
);
COMMENT ON TABLE public.z01_wbk_hrh_table IS 'ОМ: объекты: рабочая книга: пространство пользователей для РК, РК, каталоги, дашборды, вмджеты, датасеты (одна связь родитель к потомку)';
COMMENT ON COLUMN public.z01_wbk_hrh_table.owner_username IS 'пространство пользователя для РК';
COMMENT ON COLUMN public.z01_wbk_hrh_table.id_subj IS 'id сущности песочницы';
COMMENT ON COLUMN public.z01_wbk_hrh_table.name_subj IS 'название сущности песочницы';
COMMENT ON COLUMN public.z01_wbk_hrh_table.creator IS 'id создателя';
COMMENT ON COLUMN public.z01_wbk_hrh_table.creator_subj IS 'логин создателя';
COMMENT ON COLUMN public.z01_wbk_hrh_table.configcreatedtime_subj IS 'время создания';
COMMENT ON COLUMN public.z01_wbk_hrh_table.ftype_subj IS 'id типа сущности песочницы';
COMMENT ON COLUMN public.z01_wbk_hrh_table.wbk_item_type_t IS 'тип сущности песочницы, текст';
COMMENT ON COLUMN public.z01_wbk_hrh_table.parent_id IS 'id родительской записи';

--
