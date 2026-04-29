--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_table_lineage_for_each (
	start_table_id text NULL, -- стартовый id ДС
	start_table_name text NULL, -- стартовое имя ДС
	path_id text NULL, -- полный путь id ДС
	path_name text NULL, -- полный путь ДС
	"level" int4 NULL, -- уровень датасета в цепочке происхождения датасетов
	end_table_id text NULL, -- завершающее id ДС
	end_table_name text NULL, -- завершающее имя ДС
	end_table_type text NULL -- тип таблицы
);
COMMENT ON TABLE public.z01_ds_table_lineage_for_each IS 'ОМ: объекты: датасеты: упоминание таблицы в путях датасетов (новая логика курсор)';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.start_table_id IS 'стартовый id ДС';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.start_table_name IS 'стартовое имя ДС';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.path_id IS 'полный путь id ДС';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.path_name IS 'полный путь ДС';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each."level" IS 'уровень датасета в цепочке происхождения датасетов';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.end_table_id IS 'завершающее id ДС';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.end_table_name IS 'завершающее имя ДС';
COMMENT ON COLUMN public.z01_ds_table_lineage_for_each.end_table_type IS 'тип таблицы';

--
