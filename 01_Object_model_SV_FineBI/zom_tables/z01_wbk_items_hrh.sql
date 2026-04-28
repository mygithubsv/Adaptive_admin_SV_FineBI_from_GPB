--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wbk_items_hrh (
	wbk_id text NULL, -- id рабочей книги
	wbk_name text NULL, -- имя рабочей книги
	wbk_path_level int4 NULL, -- уровень вложенности рабочей книги
	wbk_dir_path_id text NULL, -- полный путь id рабочей книги
	wbk_dir_path_name text NULL, -- полный путь рабочей книги
	wbk_dir_path_name_type text NULL, -- полный путь рабочей книги с типами
	e1_name varchar NULL, -- путь рабочей книги ур.1
	e1_wbk_id text NULL, -- путь id рабочей книги ур.1
	e2_name text NULL, -- путь рабочей книги ур.2
	e2_wbk_id text NULL, -- путь id рабочей книги ур.2
	e3_name text NULL, -- путь рабочей книги ур.3
	e3_wbk_id text NULL, -- путь id рабочей книги ур.3
	e4_name text NULL, -- путь рабочей книги ур.4
	e4_wbk_id text NULL, -- путь id рабочей книги ур.4
	e5_name text NULL, -- путь рабочей книги ур.5
	e5_wbk_id text NULL, -- путь id рабочей книги ур.5
	e6_name text NULL, -- путь рабочей книги ур.6
	e6_wbk_id text NULL, -- путь id рабочей книги ур.6
	e7_name text NULL, -- путь рабочей книги ур.7
	e7_wbk_id text NULL, -- путь id рабочей книги ур.7
	e8_name text NULL, -- путь рабочей книги ур.8
	e8_wbk_id text NULL, -- путь id рабочей книги ур.8
	e9_name text NULL, -- путь рабочей книги ур.9
	e9_wbk_id text NULL, -- путь id рабочей книги ур.9
	e10_name text NULL, -- путь рабочей книги ур.10
	e10_wbk_id text NULL -- путь id рабочей книги ур.10
);
COMMENT ON TABLE public.z01_wbk_items_hrh IS 'ОМ: объекты: рабочая книга: иерархия элементов в строку';
COMMENT ON COLUMN public.z01_wbk_items_hrh.wbk_id IS 'id рабочей книги';
COMMENT ON COLUMN public.z01_wbk_items_hrh.wbk_name IS 'имя рабочей книги';
COMMENT ON COLUMN public.z01_wbk_items_hrh.wbk_path_level IS 'уровень вложенности рабочей книги';
COMMENT ON COLUMN public.z01_wbk_items_hrh.wbk_dir_path_id IS 'полный путь id рабочей книги';
COMMENT ON COLUMN public.z01_wbk_items_hrh.wbk_dir_path_name IS 'полный путь рабочей книги';
COMMENT ON COLUMN public.z01_wbk_items_hrh.wbk_dir_path_name_type IS 'полный путь рабочей книги с типами';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e1_name IS 'путь рабочей книги ур.1';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e1_wbk_id IS 'путь id рабочей книги ур.1';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e2_name IS 'путь рабочей книги ур.2';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e2_wbk_id IS 'путь id рабочей книги ур.2';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e3_name IS 'путь рабочей книги ур.3';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e3_wbk_id IS 'путь id рабочей книги ур.3';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e4_name IS 'путь рабочей книги ур.4';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e4_wbk_id IS 'путь id рабочей книги ур.4';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e5_name IS 'путь рабочей книги ур.5';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e5_wbk_id IS 'путь id рабочей книги ур.5';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e6_name IS 'путь рабочей книги ур.6';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e6_wbk_id IS 'путь id рабочей книги ур.6';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e7_name IS 'путь рабочей книги ур.7';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e7_wbk_id IS 'путь id рабочей книги ур.7';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e8_name IS 'путь рабочей книги ур.8';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e8_wbk_id IS 'путь id рабочей книги ур.8';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e9_name IS 'путь рабочей книги ур.9';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e9_wbk_id IS 'путь id рабочей книги ур.9';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e10_name IS 'путь рабочей книги ур.10';
COMMENT ON COLUMN public.z01_wbk_items_hrh.e10_wbk_id IS 'путь id рабочей книги ур.10';

--
