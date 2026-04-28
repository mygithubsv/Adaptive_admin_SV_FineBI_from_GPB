--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_msr_list (
	dsm_id_uniq text NULL, -- ID датасета
	dsm_msr_id text NULL, -- ID меры
	dsm_msr_name text NULL, -- Название меры
	dsm_msr_creator_id text NULL, -- ID создателя меры
	dsm_msr_created timestamp NULL, -- Время создания меры
	dsm_msr_type text NULL, -- Тип данных меры
	dsm_msr_measuretype text NULL, -- Тип меры
	dsm_msr_enginetype text NULL, -- ?
	dsm_msr_updated timestamp NULL -- Дата изменения меры
);
COMMENT ON TABLE public.z01_ds_msr_list IS 'ОМ: объекты: датасеты: индикаторы';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_id_uniq IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_id IS 'ID меры';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_name IS 'Название меры';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_creator_id IS 'ID создателя меры';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_created IS 'Время создания меры';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_type IS 'Тип данных меры';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_measuretype IS 'Тип меры';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_enginetype IS '?';
COMMENT ON COLUMN public.z01_ds_msr_list.dsm_msr_updated IS 'Дата изменения меры';

--
