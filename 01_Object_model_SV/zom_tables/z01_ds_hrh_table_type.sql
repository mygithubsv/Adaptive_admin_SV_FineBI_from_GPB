--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_hrh_table_type (
	dsm_id_child text NULL, -- id потомка
	dsm_name_child text NULL, -- название потомка
	dsm_id_parent text NULL, -- id родителя
	dsm_name_parent text NULL, -- название потомка
	type_ent text NULL -- Тип элемента: каталог или датасет
);
COMMENT ON TABLE public.z01_ds_hrh_table_type IS 'ОМ: объекты: датасеты: элементы раздела "Источники": каталоги и датасеты';
COMMENT ON COLUMN public.z01_ds_hrh_table_type.dsm_id_child IS 'id потомка';
COMMENT ON COLUMN public.z01_ds_hrh_table_type.dsm_name_child IS 'название потомка';
COMMENT ON COLUMN public.z01_ds_hrh_table_type.dsm_id_parent IS 'id родителя';
COMMENT ON COLUMN public.z01_ds_hrh_table_type.dsm_name_parent IS 'название потомка';
COMMENT ON COLUMN public.z01_ds_hrh_table_type.type_ent IS 'Тип элемента: каталог или датасет';

--
