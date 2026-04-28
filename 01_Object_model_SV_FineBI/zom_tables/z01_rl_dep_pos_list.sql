--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_rl_dep_pos_list (
	dpm_id varchar(255) NULL, -- ID департамента (подразделения)
	dpm_name varchar(255) NULL, -- Название департамента (подразделения)
	dpm_pos_name varchar(255) NULL, -- Название позиции
	dpm_path_ui text NULL, -- Путь в иерархии
	dpm_level int4 NULL, -- Уровень размещения в иерархии
	dpm_p1 text NULL, -- Каталог уровня 1
	dpm_p2 text NULL, -- Каталог уровня 2
	dpm_p3 text NULL, -- Каталог уровня 3
	dpm_p4 text NULL, -- Каталог уровня 4
	dpm_p5 text NULL, -- Каталог уровня 5
	dpm_p6 text NULL, -- Каталог уровня 6
	dpm_p7 text NULL, -- Каталог уровня 7
	dpm_p8 text NULL, -- Каталог уровня 8
	dpm_p9 text NULL, -- Каталог уровня 9
	dpm_p10 text NULL -- Каталог уровня 10
);
COMMENT ON TABLE public.z01_rl_dep_pos_list IS 'ОМ: роли: департаменты с позициями';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_id IS 'ID департамента (подразделения)';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_name IS 'Название департамента (подразделения)';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_pos_name IS 'Название позиции';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_path_ui IS 'Путь в иерархии';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_level IS 'Уровень размещения в иерархии';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p1 IS 'Каталог уровня 1';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p2 IS 'Каталог уровня 2';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p3 IS 'Каталог уровня 3';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p4 IS 'Каталог уровня 4';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p5 IS 'Каталог уровня 5';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p6 IS 'Каталог уровня 6';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p7 IS 'Каталог уровня 7';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p8 IS 'Каталог уровня 8';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p9 IS 'Каталог уровня 9';
COMMENT ON COLUMN public.z01_rl_dep_pos_list.dpm_p10 IS 'Каталог уровня 10';

--
