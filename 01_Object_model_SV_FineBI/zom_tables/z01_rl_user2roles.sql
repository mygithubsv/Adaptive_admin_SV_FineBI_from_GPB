--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_rl_user2roles (
	user_id varchar(255) NULL, -- id УЗ
	user_name varchar(255) NULL, -- логин УЗ
	user_fio varchar(255) NULL, -- ФИО УЗ
	role_name varchar(255) NULL, -- полное название роли
	role_id varchar(255) NULL, -- id роли
	is_platform int4 NULL, -- признак активации на платформе
	is_viewer int4 NULL, -- признак лицензии пользователя
	is_dev int4 NULL -- признак лицензии разработчика
);
COMMENT ON TABLE public.z01_rl_user2roles IS 'ОМ: роли: отнесение пользователей на контентные роли каталогов и признаки лицензий';
COMMENT ON COLUMN public.z01_rl_user2roles.user_id IS 'id УЗ';
COMMENT ON COLUMN public.z01_rl_user2roles.user_name IS 'логин УЗ';
COMMENT ON COLUMN public.z01_rl_user2roles.user_fio IS 'ФИО УЗ';
COMMENT ON COLUMN public.z01_rl_user2roles.role_name IS 'полное название роли';
COMMENT ON COLUMN public.z01_rl_user2roles.role_id IS 'id роли';
COMMENT ON COLUMN public.z01_rl_user2roles.is_platform IS 'признак активации на платформе';
COMMENT ON COLUMN public.z01_rl_user2roles.is_viewer IS 'признак лицензии пользователя';
COMMENT ON COLUMN public.z01_rl_user2roles.is_dev IS 'признак лицензии разработчика';

--
