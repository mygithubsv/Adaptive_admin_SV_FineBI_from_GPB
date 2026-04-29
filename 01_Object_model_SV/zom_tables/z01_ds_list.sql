--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_list (
	dsm_id text NULL, -- id датасета
	dsm_name text NULL, -- название датасета
	dsm_config_created timestamp NULL, -- дата создания датасета
	dsm_driver_type text NULL, -- тип датасета
	dsm_db_name text NULL, -- название таблицы датасета БД или серверного датасета
	dsm_con_name text NULL, -- название подключения
	dsm_creator_id text NULL, -- id УЗ создателя датасета
	dsm_creator_name varchar(255) NULL -- название УЗ создателя датасета
);
COMMENT ON TABLE public.z01_ds_list IS 'ОМ: объекты: датасеты: датасеты с подключениями';
COMMENT ON COLUMN public.z01_ds_list.dsm_id IS 'id датасета';
COMMENT ON COLUMN public.z01_ds_list.dsm_name IS 'название датасета';
COMMENT ON COLUMN public.z01_ds_list.dsm_config_created IS 'дата создания датасета';
COMMENT ON COLUMN public.z01_ds_list.dsm_driver_type IS 'тип датасета';
COMMENT ON COLUMN public.z01_ds_list.dsm_db_name IS 'название таблицы датасета БД или серверного датасета';
COMMENT ON COLUMN public.z01_ds_list.dsm_con_name IS 'название подключения';
COMMENT ON COLUMN public.z01_ds_list.dsm_creator_id IS 'id УЗ создателя датасета';
COMMENT ON COLUMN public.z01_ds_list.dsm_creator_name IS 'название УЗ создателя датасета';

--
