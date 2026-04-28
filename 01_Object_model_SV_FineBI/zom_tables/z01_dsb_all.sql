--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_dsb_all (
	dm_dash_name text NULL, -- название дашборда
	dd_path_fine_bi text NULL, -- полный путь в "Коллекции"
	dd_path_1 text NULL, -- путь в "Коллекции" ур.1
	dd_path_2 text NULL, -- путь в "Коллекции" ур.2
	dd_path_3 text NULL, -- путь в "Коллекции" ур.3
	dd_path_4 text NULL, -- путь в "Коллекции" ур.4
	dd_path_5 text NULL, -- путь в "Коллекции" ур.5
	dd_path_6 text NULL, -- путь в "Коллекции" ур.6
	dd_path_7 text NULL, -- путь в "Коллекции" ур.7
	dd_path_8 text NULL, -- путь в "Коллекции" ур.8
	dd_path_9 text NULL, -- путь в "Коллекции" ур.9
	dd_dev_name_full text NULL, -- ФИО разработчика
	dd_dev_login text NULL, -- логин разработчика
	dd_path_dev_directory text NULL, -- путь в "Песочнице"
	dm_createddate timestamp NULL, -- дата создания
	dm_updatedate timestamp NULL, -- дата обновления
	dm_publish_name text NULL, -- ФИО публикующего
	dm_publish_login text NULL, -- логин публикующего
	dm_dash_link text NULL, -- ссылка на даш
	dd_rn_dash_group int4 NULL, -- номер даша в каталоге
	dd_rn_dash int4 NULL, -- сквозной номер дашборда
	dm_dash_id text NULL, -- id дашборда
	is_public_link int4 NULL, -- признак публичной ссылки
	dm_is_publish int4 NULL, -- признак публикации
	dm_expandid_a text NULL, -- id точки "Коллекции"
	dm_username varchar(255) NULL, -- логин разработчика
	dm_user_id text NULL, -- id разработчика
	dm_link_id text NULL, -- ссылка URL
	dm_is_shared int4 NULL, -- признак расшаренного дашборда
	dm_is_pwprotect int4 NULL, -- признак защищенного паролем публичного дашборда
	dm_deadline timestamp NULL -- дата окончания действия публичной ссылки
);
COMMENT ON TABLE public.z01_dsb_all IS 'ОМ: объекты: дашборды: обобщённое представление';
COMMENT ON COLUMN public.z01_dsb_all.dm_dash_name IS 'название дашборда';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_fine_bi IS 'полный путь в "Коллекции"';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_1 IS 'путь в "Коллекции" ур.1';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_2 IS 'путь в "Коллекции" ур.2';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_3 IS 'путь в "Коллекции" ур.3';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_4 IS 'путь в "Коллекции" ур.4';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_5 IS 'путь в "Коллекции" ур.5';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_6 IS 'путь в "Коллекции" ур.6';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_7 IS 'путь в "Коллекции" ур.7';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_8 IS 'путь в "Коллекции" ур.8';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_9 IS 'путь в "Коллекции" ур.9';
COMMENT ON COLUMN public.z01_dsb_all.dd_dev_name_full IS 'ФИО разработчика';
COMMENT ON COLUMN public.z01_dsb_all.dd_dev_login IS 'логин разработчика';
COMMENT ON COLUMN public.z01_dsb_all.dd_path_dev_directory IS 'путь в "Песочнице"';
COMMENT ON COLUMN public.z01_dsb_all.dm_createddate IS 'дата создания';
COMMENT ON COLUMN public.z01_dsb_all.dm_updatedate IS 'дата обновления';
COMMENT ON COLUMN public.z01_dsb_all.dm_publish_name IS 'ФИО публикующего';
COMMENT ON COLUMN public.z01_dsb_all.dm_publish_login IS 'логин публикующего';
COMMENT ON COLUMN public.z01_dsb_all.dm_dash_link IS 'ссылка на даш';
COMMENT ON COLUMN public.z01_dsb_all.dd_rn_dash_group IS 'номер даша в каталоге';
COMMENT ON COLUMN public.z01_dsb_all.dd_rn_dash IS 'сквозной номер дашборда';
COMMENT ON COLUMN public.z01_dsb_all.dm_dash_id IS 'id дашборда';
COMMENT ON COLUMN public.z01_dsb_all.is_public_link IS 'признак публичной ссылки';
COMMENT ON COLUMN public.z01_dsb_all.dm_is_publish IS 'признак публикации';
COMMENT ON COLUMN public.z01_dsb_all.dm_expandid_a IS 'id точки "Коллекции"';
COMMENT ON COLUMN public.z01_dsb_all.dm_username IS 'логин разработчика';
COMMENT ON COLUMN public.z01_dsb_all.dm_user_id IS 'id разработчика';
COMMENT ON COLUMN public.z01_dsb_all.dm_link_id IS 'ссылка URL';
COMMENT ON COLUMN public.z01_dsb_all.dm_is_shared IS 'признак расшаренного дашборда';
COMMENT ON COLUMN public.z01_dsb_all.dm_is_pwprotect IS 'признак защищенного паролем публичного дашборда';
COMMENT ON COLUMN public.z01_dsb_all.dm_deadline IS 'дата окончания действия публичной ссылки';

--
