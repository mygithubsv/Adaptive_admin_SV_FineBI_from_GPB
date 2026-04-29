--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_zom_group_table (
	group_table text COLLATE "C" NULL, -- Название таблицы
	group_description varchar NULL -- Название группы таблиц
);
COMMENT ON TABLE public.z01_zom_group_table IS 'ОМ: словарь: группы таблиц в общих представлениях ОМ';
COMMENT ON COLUMN public.z01_zom_group_table.group_table IS 'Название таблицы';
COMMENT ON COLUMN public.z01_zom_group_table.group_description IS 'Название группы таблиц';

--
