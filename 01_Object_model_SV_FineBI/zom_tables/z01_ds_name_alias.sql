--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_name_alias (
	dsm_id text NULL, -- ID датасета
	dsm_alias_name text NULL -- Название датасета (алиас) в UI
);
COMMENT ON TABLE public.z01_ds_name_alias IS 'ОМ: объекты: датасеты: синонимы таблиц';
COMMENT ON COLUMN public.z01_ds_name_alias.dsm_id IS 'ID датасета';
COMMENT ON COLUMN public.z01_ds_name_alias.dsm_alias_name IS 'Название датасета (алиас) в UI';

--
