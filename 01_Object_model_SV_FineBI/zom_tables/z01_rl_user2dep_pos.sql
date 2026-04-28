--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_rl_user2dep_pos (
	dpd_id varchar(255) NULL, -- ID департамента
	dpd_name varchar(255) NULL, -- Название департамента
	dpd_path_ui text NULL, -- Путь в иерархии
	dpd_level int4 NULL, -- Уровень в иерархии
	dpd_p1 text NULL, -- Каталог уровня 1
	dpd_p2 text NULL, -- Каталог уровня 2
	dpd_p3 text NULL, -- Каталог уровня 3
	dpd_p4 text NULL, -- Каталог уровня 4
	dpd_p5 text NULL, -- Каталог уровня 5
	dpd_p6 text NULL, -- Каталог уровня 6
	dpd_p7 text NULL, -- Каталог уровня 7
	dpd_p8 text NULL, -- Каталог уровня 8
	dpd_p9 text NULL, -- Каталог уровня 9
	dpd_p10 text NULL, -- Каталог уровня 10
	dpd_user_realname varchar(255) NULL, -- ФИО пользователя
	dpd_user_email varchar(255) NULL, -- Email пользователя
	dpd_user_id varchar(255) NULL, -- ID пользователя
	dpd_userid text NULL, -- ID пользователя (без дефисов)
	dpd_username varchar(255) NULL -- логин пользователя
);
COMMENT ON TABLE public.z01_rl_user2dep_pos IS 'ОМ: роли: отнесение пользователей на департаменты с позициями';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_id IS 'ID департамента';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_name IS 'Название департамента';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_path_ui IS 'Путь в иерархии';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_level IS 'Уровень в иерархии';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p1 IS 'Каталог уровня 1';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p2 IS 'Каталог уровня 2';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p3 IS 'Каталог уровня 3';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p4 IS 'Каталог уровня 4';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p5 IS 'Каталог уровня 5';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p6 IS 'Каталог уровня 6';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p7 IS 'Каталог уровня 7';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p8 IS 'Каталог уровня 8';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p9 IS 'Каталог уровня 9';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_p10 IS 'Каталог уровня 10';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_user_realname IS 'ФИО пользователя';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_user_email IS 'Email пользователя';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_user_id IS 'ID пользователя';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_userid IS 'ID пользователя (без дефисов)';
COMMENT ON COLUMN public.z01_rl_user2dep_pos.dpd_username IS 'логин пользователя';

--
