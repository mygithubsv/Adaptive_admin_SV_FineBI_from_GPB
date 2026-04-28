--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_table_lineage (
	dsd_pos_id_in_list text NULL, -- Позиция в последовательности origin (FROM, MID, TO)
	dsd_pos_order_num int4 NULL, -- Номер позиции используемого датасета в последовательности
	dsd_level int4 NULL, -- Последняя позиция последовательности
	dsm_driver_type text NULL, -- Тип драйвера
	dsd_table_name text NULL, -- Название датасета (используемый в последовательности, может быть и FROM, и TO)
	dsd_path_name_type text NULL, -- Полная последовательность датасетов от FROM до TO через MID с указанием типа датасетов
	dsd_path_name text NULL, -- Полная последовательность датасетов от FROM до TO через MID
	dsm_id_from text NULL, -- id датасета первого в последовательности
	dsm_id_pass text NULL, -- id датасета используемого в последовательности
	dsm_id_to text NULL, -- id датасета последнего в последовательности
	dsd_path_id text NULL -- Полная последовательность id датасетов от FROM до TO через MID
);
COMMENT ON TABLE public.z01_ds_table_lineage IS 'ОМ: объекты: датасеты: origin датасетов';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_pos_id_in_list IS 'Позиция в последовательности origin (FROM, MID, TO)';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_pos_order_num IS 'Номер позиции используемого датасета в последовательности';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_level IS 'Последняя позиция последовательности';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsm_driver_type IS 'Тип драйвера';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_table_name IS 'Название датасета (используемый в последовательности, может быть и FROM, и TO)';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_path_name_type IS 'Полная последовательность датасетов от FROM до TO через MID с указанием типа датасетов';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_path_name IS 'Полная последовательность датасетов от FROM до TO через MID';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsm_id_from IS 'id датасета первого в последовательности';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsm_id_pass IS 'id датасета используемого в последовательности';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsm_id_to IS 'id датасета последнего в последовательности';
COMMENT ON COLUMN public.z01_ds_table_lineage.dsd_path_id IS 'Полная последовательность id датасетов от FROM до TO через MID';

--
