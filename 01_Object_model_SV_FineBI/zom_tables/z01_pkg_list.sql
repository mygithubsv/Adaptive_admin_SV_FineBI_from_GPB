--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_pkg_list (
	pkm_id text NULL, -- ID каталога датасетов
	pkm_name text NULL, -- Название каталога датасетов
	pkm_creator_id text NULL, -- ID создателя каталога датасетов
	pkm_creator_name varchar(255) NULL, -- Создатель каталога датасетов
	pkm_config_created timestamp NULL -- Дата создания каталога датасетов
);
COMMENT ON TABLE public.z01_pkg_list IS 'ОМ: объекты: дашборды: каталоги датасетов';
COMMENT ON COLUMN public.z01_pkg_list.pkm_id IS 'ID каталога датасетов';
COMMENT ON COLUMN public.z01_pkg_list.pkm_name IS 'Название каталога датасетов';
COMMENT ON COLUMN public.z01_pkg_list.pkm_creator_id IS 'ID создателя каталога датасетов';
COMMENT ON COLUMN public.z01_pkg_list.pkm_creator_name IS 'Создатель каталога датасетов';
COMMENT ON COLUMN public.z01_pkg_list.pkm_config_created IS 'Дата создания каталога датасетов';

--
