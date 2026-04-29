--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_prm_list_con (
	pm_user_id varchar(255) NULL, -- ID пользователя
	pm_username varchar(255) NULL, -- УЗ пользователя
	pm_realname varchar(255) NULL, -- ФИО пользователя
	pm_con_name varchar(255) NULL, -- Подключение
	pm_cat_perm text NULL, -- Категория разрешения
	pd_type text NULL, -- Тип роли
	pm_type_value varchar NULL, -- Название роли
	pm_authoritytype int4 NULL -- ID категории разрешения
);
COMMENT ON TABLE public.z01_prm_list_con IS '>ОМ: разрешения: доступы УЗ к подключениям';
COMMENT ON COLUMN public.z01_prm_list_con.pm_user_id IS 'ID пользователя';
COMMENT ON COLUMN public.z01_prm_list_con.pm_username IS 'УЗ пользователя';
COMMENT ON COLUMN public.z01_prm_list_con.pm_realname IS 'ФИО пользователя';
COMMENT ON COLUMN public.z01_prm_list_con.pm_con_name IS 'Подключение';
COMMENT ON COLUMN public.z01_prm_list_con.pm_cat_perm IS 'Категория разрешения';
COMMENT ON COLUMN public.z01_prm_list_con.pd_type IS 'Тип роли';
COMMENT ON COLUMN public.z01_prm_list_con.pm_type_value IS 'Название роли';
COMMENT ON COLUMN public.z01_prm_list_con.pm_authoritytype IS 'ID категории разрешения';

--
