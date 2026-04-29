--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_clc_dir_list (
	dir_id varchar(255) NULL, -- id каталога "Коллекции"
	dir_lvl int4 NULL, -- уровень каталога "Коллекции" в иерархии
	dir_name varchar(255) NULL, -- название каталога "Коллекции"
	dir_description text NULL, -- описание каталога "Коллекции"
	dir_path text NULL, -- полный путь каталога в "Коллекции"
	dir_path1 text NULL, -- каталог уровня 1 из пути в "Коллекции"
	dir_path2 text NULL, -- каталог уровня 2 из пути в "Коллекции"
	dir_path3 text NULL, -- каталог уровня 3 из пути в "Коллекции"
	dir_path4 text NULL, -- каталог уровня 4 из пути в "Коллекции"
	dir_path5 text NULL, -- каталог уровня 5 из пути в "Коллекции"
	dir_path6 text NULL, -- каталог уровня 6 из пути в "Коллекции"
	dir_path7 text NULL, -- каталог уровня 7 из пути в "Коллекции"
	dir_path8 text NULL, -- каталог уровня 8 из пути в "Коллекции"
	dir_path9 text NULL, -- каталог уровня 9 из пути в "Коллекции"
	dir_path10 text NULL -- каталог уровня 10 из пути в "Коллекции"
);
COMMENT ON TABLE public.z01_clc_dir_list IS 'ОМ: объекты: каталоги "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_id IS 'id каталога "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_lvl IS 'уровень каталога "Коллекции" в иерархии';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_name IS 'название каталога "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_description IS 'описание каталога "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path IS 'полный путь каталога в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path1 IS 'каталог уровня 1 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path2 IS 'каталог уровня 2 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path3 IS 'каталог уровня 3 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path4 IS 'каталог уровня 4 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path5 IS 'каталог уровня 5 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path6 IS 'каталог уровня 6 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path7 IS 'каталог уровня 7 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path8 IS 'каталог уровня 8 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path9 IS 'каталог уровня 9 из пути в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_dir_list.dir_path10 IS 'каталог уровня 10 из пути в "Коллекции"';

--
