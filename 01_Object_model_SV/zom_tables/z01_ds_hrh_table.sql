--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_hrh_table (
	dsm_id_child text NULL, -- ID дочернего элемента иерархии (потомка)
	dsm_name_child text NULL, -- Название дочернего элемента иерархии (потомка)
	dsm_id_parent text NULL, -- ID родительского элемента иерархии (предка)
	dsm_name_parent text NULL, -- Название родительского элемента иерархии (предка)
	dsm_entity_key_ds text NULL, -- ID датасета
	dsd_trans_name text NULL -- Название датасета
);
COMMENT ON TABLE public.z01_ds_hrh_table IS 'ОМ: объекты: датасеты: отношение между двумя датасетами и каталогами';
COMMENT ON COLUMN public.z01_ds_hrh_table.dsm_id_child IS 'ID дочернего элемента иерархии (потомка)';
COMMENT ON COLUMN public.z01_ds_hrh_table.dsm_name_child IS 'Название дочернего элемента иерархии (потомка)';
COMMENT ON COLUMN public.z01_ds_hrh_table.dsm_id_parent IS 'ID родительского элемента иерархии (предка)';
COMMENT ON COLUMN public.z01_ds_hrh_table.dsm_name_parent IS 'Название родительского элемента иерархии (предка)';
COMMENT ON COLUMN public.z01_ds_hrh_table.dsm_entity_key_ds IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_hrh_table.dsd_trans_name IS 'Название датасета';

--
