--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_ec2tableid (
	dsm_table_id text NULL, -- ID датасета - 16v32 Az09
	dsm_table_name text NULL, -- Название датасета - уникальное как доп. ID (mix dsm_table_id+P@@@+_S+_D)
	dsd_table_name text NULL, -- Название датасета - неуникальное как в UI ПО
	dsm_driver_type text NULL -- Тип датасета (sql, db, excel, analysis)
);
COMMENT ON TABLE public.z01_ds_ec2tableid IS '>ОМ: объекты: датасеты: список';
COMMENT ON COLUMN public.z01_ds_ec2tableid.dsm_table_id IS 'ID датасета - 16v32 Az09';
COMMENT ON COLUMN public.z01_ds_ec2tableid.dsm_table_name IS 'Название датасета - уникальное как доп. ID (mix dsm_table_id+P@@@+_S+_D)';
COMMENT ON COLUMN public.z01_ds_ec2tableid.dsd_table_name IS 'Название датасета - неуникальное как в UI ПО';
COMMENT ON COLUMN public.z01_ds_ec2tableid.dsm_driver_type IS 'Тип датасета (sql, db, excel, analysis)';

--
