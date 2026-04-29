--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wbk_hrh_list (
	owner_username varchar NULL, -- Владелец рабочей книги
	created_dt timestamp NULL, -- Время создания
	item_id text NULL, -- id сущности
	item_type text NULL, -- тип сущности
	item_name text NULL, -- название сущности рабочей книги
	parent_id text NULL, -- id родителя
	parent_name text NULL, -- название родителя
	item_level int4 NULL, -- уровень элемента
	path_id text NULL, -- Полный путь id от пространства пользователя до каталога сущности рабочей книги
	path_name text NULL, -- Полный путь от пространства пользователя до каталога сущности рабочей книги
	e1_name text NULL, -- Иерархия каталогов ур.1
	e1_id text NULL, -- id каталога иерархии ур.1
	e2_name text NULL, -- Иерархия каталогов ур.2
	e2_id text NULL, -- id каталога иерархии ур.2
	e3_name text NULL, -- Иерархия каталогов ур.3
	e3_id text NULL, -- id каталога иерархии ур.3
	e4_name text NULL, -- Иерархия каталогов ур.4
	e4_id text NULL, -- id каталога иерархии ур.4
	e5_name text NULL, -- Иерархия каталогов ур.5
	e5_id text NULL, -- id каталога иерархии ур.5
	e6_name text NULL, -- Иерархия каталогов ур.6
	e6_id text NULL, -- id каталога иерархии ур.6
	e7_name text NULL, -- Иерархия каталогов ур.7
	e7_id text NULL, -- id каталога иерархии ур.7
	e8_name text NULL, -- Иерархия каталогов ур.8
	e8_id text NULL, -- id каталога иерархии ур.8
	e9_name text NULL, -- Иерархия каталогов ур.9
	e9_id text NULL, -- id каталога иерархии ур.9
	e10_name text NULL, -- Иерархия каталогов ур.10
	e10_id text NULL -- id каталога иерархии ур.10
);
COMMENT ON TABLE public.z01_wbk_hrh_list IS 'ОМ: объекты: рабочая книга: пространство пользователей для РК с  составными элементами';
COMMENT ON COLUMN public.z01_wbk_hrh_list.owner_username IS 'Владелец рабочей книги';
COMMENT ON COLUMN public.z01_wbk_hrh_list.created_dt IS 'Время создания';
COMMENT ON COLUMN public.z01_wbk_hrh_list.item_id IS 'id сущности';
COMMENT ON COLUMN public.z01_wbk_hrh_list.item_type IS 'тип сущности';
COMMENT ON COLUMN public.z01_wbk_hrh_list.item_name IS 'название сущности рабочей книги';
COMMENT ON COLUMN public.z01_wbk_hrh_list.parent_id IS 'id родителя';
COMMENT ON COLUMN public.z01_wbk_hrh_list.parent_name IS 'название родителя';
COMMENT ON COLUMN public.z01_wbk_hrh_list.item_level IS 'уровень элемента';
COMMENT ON COLUMN public.z01_wbk_hrh_list.path_id IS 'Полный путь id от пространства пользователя до каталога сущности рабочей книги';
COMMENT ON COLUMN public.z01_wbk_hrh_list.path_name IS 'Полный путь от пространства пользователя до каталога сущности рабочей книги';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e1_name IS 'Иерархия каталогов ур.1';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e1_id IS 'id каталога иерархии ур.1';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e2_name IS 'Иерархия каталогов ур.2';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e2_id IS 'id каталога иерархии ур.2';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e3_name IS 'Иерархия каталогов ур.3';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e3_id IS 'id каталога иерархии ур.3';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e4_name IS 'Иерархия каталогов ур.4';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e4_id IS 'id каталога иерархии ур.4';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e5_name IS 'Иерархия каталогов ур.5';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e5_id IS 'id каталога иерархии ур.5';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e6_name IS 'Иерархия каталогов ур.6';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e6_id IS 'id каталога иерархии ур.6';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e7_name IS 'Иерархия каталогов ур.7';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e7_id IS 'id каталога иерархии ур.7';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e8_name IS 'Иерархия каталогов ур.8';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e8_id IS 'id каталога иерархии ур.8';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e9_name IS 'Иерархия каталогов ур.9';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e9_id IS 'id каталога иерархии ур.9';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e10_name IS 'Иерархия каталогов ур.10';
COMMENT ON COLUMN public.z01_wbk_hrh_list.e10_id IS 'id каталога иерархии ур.10';

--
