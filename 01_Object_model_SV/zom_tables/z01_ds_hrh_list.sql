--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_hrh_list (
	dsm_id text NULL, -- ID датасета
	dsm_name_uniq text NULL, -- Название датасета
	dsd_path_ds text NULL, -- Путь размещения датасета в иерархии Public Data
	dsm_level int4 NULL, -- Уровень размещения датасета в иерархии Public Data
	dsd_e1_name text NULL, -- Название уровня 1
	dsd_e1_pkg_ds_id text NULL, -- ID уровня 1
	dsd_e2_name text NULL, -- Название уровня 2
	dsd_e2_pkg_ds_id text NULL, -- ID уровня 2
	dsd_e3_name text NULL, -- Название уровня 3
	dsd_e3_pkg_ds_id text NULL, -- ID уровня 3
	dsd_e4_name text NULL, -- Название уровня 4
	dsd_e4_pkg_ds_id text NULL, -- ID уровня 4
	dsd_e5_name text NULL, -- Название уровня 5
	dsd_e5_pkg_ds_id text NULL, -- ID уровня 5
	dsd_e6_name text NULL, -- Название уровня 6
	dsd_e6_pkg_ds_id text NULL, -- ID уровня 6
	dsd_e7_name text NULL, -- Название уровня 7
	dsd_e7_pkg_ds_id text NULL, -- ID уровня 7
	dsd_e8_name text NULL, -- Название уровня 8
	dsd_e8_pkg_ds_id text NULL, -- ID уровня 8
	dsd_e9_name text NULL, -- Название уровня 9
	dsd_e9_pkg_ds_id text NULL, -- ID уровня 9
	dsd_e10_name text NULL, -- Название уровня 10
	dsd_e10_pkg_ds_id text NULL, -- ID уровня 10
	dsd_path_ds_id text NULL -- Путь id размещения датасета в иерархии Public Data
);
COMMENT ON TABLE public.z01_ds_hrh_list IS 'ОМ: объекты: датасеты: иерархия датасетов в каталогах';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsm_name_uniq IS 'Название датасета';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_path_ds IS 'Путь размещения датасета в иерархии Public Data';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsm_level IS 'Уровень размещения датасета в иерархии Public Data';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e1_name IS 'Название уровня 1';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e1_pkg_ds_id IS 'ID уровня 1';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e2_name IS 'Название уровня 2';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e2_pkg_ds_id IS 'ID уровня 2';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e3_name IS 'Название уровня 3';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e3_pkg_ds_id IS 'ID уровня 3';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e4_name IS 'Название уровня 4';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e4_pkg_ds_id IS 'ID уровня 4';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e5_name IS 'Название уровня 5';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e5_pkg_ds_id IS 'ID уровня 5';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e6_name IS 'Название уровня 6';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e6_pkg_ds_id IS 'ID уровня 6';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e7_name IS 'Название уровня 7';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e7_pkg_ds_id IS 'ID уровня 7';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e8_name IS 'Название уровня 8';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e8_pkg_ds_id IS 'ID уровня 8';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e9_name IS 'Название уровня 9';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e9_pkg_ds_id IS 'ID уровня 9';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e10_name IS 'Название уровня 10';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_e10_pkg_ds_id IS 'ID уровня 10';
COMMENT ON COLUMN public.z01_ds_hrh_list.dsd_path_ds_id IS 'Путь id размещения датасета в иерархии Public Data';

--
