--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_prm_list_dsb (
	pm_user_id varchar(255) NULL, -- ID пользователя
	pm_username varchar(255) NULL, -- УЗ пользователя
	pm_realname varchar(255) NULL, -- ФИО пользователя
	pm_dash_id varchar(255) NULL, -- ID дашборда
	pm_dash_name varchar(255) NULL, -- Название дашборда
	pm_cat_perm text NULL, -- Категория разрешения
	pm_type text NULL, -- Тип роли
	pm_type_value varchar NULL, -- Название роли
	pm_is_pc_enable int4 NULL, -- Признак: 1 - доступен с ПК
	pm_is_tablet_enable int4 NULL, -- Признак: 1 - доступен с планшета
	pm_is_phone_enable int4 NULL -- Признак: 1 - доступен с телефона
);
COMMENT ON TABLE public.z01_prm_list_dsb IS '>ОМ: разрешения: доступы УЗ к дашбордам (публикации коллекции)';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_user_id IS 'ID пользователя';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_username IS 'УЗ пользователя';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_realname IS 'ФИО пользователя';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_dash_id IS 'ID дашборда';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_dash_name IS 'Название дашборда';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_cat_perm IS 'Категория разрешения';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_type IS 'Тип роли';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_type_value IS 'Название роли';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_is_pc_enable IS 'Признак: 1 - доступен с ПК';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_is_tablet_enable IS 'Признак: 1 - доступен с планшета';
COMMENT ON COLUMN public.z01_prm_list_dsb.pm_is_phone_enable IS 'Признак: 1 - доступен с телефона';

--
