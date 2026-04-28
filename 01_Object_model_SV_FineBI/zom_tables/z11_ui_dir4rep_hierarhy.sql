--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z11_ui_dir4rep_hierarhy (
	sd_platform_name text NULL, -- Название модуля
	sm_is_publish int4 NULL, -- Признак публикации
	sm_expand_id text NULL, -- Точка публикации в "Коллекция"
	sm_is_pc_enable int4 NULL, -- Доступен с ПК
	sm_is_tablet_enable int4 NULL, -- Доступен с планшета
	sm_is_phone_enable int4 NULL, -- Доступен с телефона
	sm_report_id text NULL, -- Шаблон BI для дашборда - ID в "Песочнице" или "Отчёты FR"
	sm_report_name text NULL, -- Шаблон BI для дашборда - название в "Песочнице" или "Отчёты FR"
	sm_expand_name text NULL, -- Шаблон BI для дашборда - название в "Коллекции"
	sd_path_fine_bi text NULL, -- Полный путь в "Коллекции"
	sd_path_1 text NULL, -- Место размещения в "Коллекции" или другое
	sd_path_2 text NULL, -- Каталог пути ур.1 в "Коллекции" или "Подразделение ур.2" разработчика для другое
	sd_path_3 text NULL, -- Каталог пути ур.2 в "Коллекции" или "Подразделение ур.3" разработчика для другое
	sd_path_4 text NULL, -- Каталог пути ур.3 в "Коллекции" или "Песочница ур.1"/"Отчёты FR ур.1" разработчика для другое
	sd_path_5 text NULL, -- Каталог пути ур.4 в "Коллекции"
	sd_path_6 text NULL, -- Каталог пути ур.5 в "Коллекции"
	sd_path_7 text NULL, -- Каталог пути ур.6 в "Коллекции"
	sd_path_8 text NULL, -- Каталог пути ур.7 в "Коллекции"
	sd_path_9 text NULL, -- Каталог пути ур.8 в "Коллекции"
	path_dev varchar(65536) NULL, -- Путь в "Песочнице" или "Отчёты FR"
	sm_created_date timestamp NULL, -- Дата монтирования в "Коллекцию"
	sm_update_date timestamp NULL, -- Дата обновления в "Коллекции"
	sm_web_link text NULL, -- Ссылка URL на отчёт в "Коллекции"
	sd_dash_lvl int4 NULL, -- Уровень дашборда в "Коллекции"
	pm_obj_id varchar(255) NULL, -- id объекта из fine_authority_object
	pm_obj_parentid varchar(255) NULL, -- parentid объекта в "Коллекции" из fine_authority_object
	pm_obj_sortindex int8 NULL, -- позиция в каталоге объекта в "Коллекции" из fine_authority_object
	pm_obj_expandtype int4 NULL, -- тип объекта в "Коллекции" из fine_authority_object
	dm_publish_name text NULL, -- Пользователь, опубликовавший дашборд
	dm_publish_login text NULL, -- Логин пользователя, опубликовавшего дашборд
	dm_publish_user_id text NULL, -- ID пользователя, опубликовавшего дашборд
	sd_path_id text NULL, -- Полный путь id в "Коллекции"
	sd_path_id_1 text NULL, -- id каталога пути ур.1 в "Коллекции" или "Подразделение ур.2" разработчика для другое
	sd_path_id_2 text NULL, -- id каталога пути ур.2 в "Коллекции" или "Подразделение ур.3" разработчика для другое
	sd_path_id_3 text NULL, -- id каталога пути ур.3 в "Коллекции" или "Песочница ур.1"/"Отчёты FR ур.1" разработчика для другое
	sd_path_id_4 text NULL, -- id каталога пути ур.4 в "Коллекции"
	sd_path_id_5 text NULL, -- id каталога пути ур.5 в "Коллекции"
	sd_path_id_6 text NULL, -- id каталога пути ур.6 в "Коллекции"
	sd_path_id_7 text NULL, -- id каталога пути ур.7 в "Коллекции"
	sd_path_id_8 text NULL, -- id каталога пути ур.8 в "Коллекции"
	sd_path_id_9 text NULL -- id каталога пути ур.9 в "Коллекции"
);
COMMENT ON TABLE public.z11_ui_dir4rep_hierarhy IS '>ОМ: объекты: дашборды: каталоги коллекции с иерархией и настройками публикаций';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_platform_name IS 'Название модуля';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_is_publish IS 'Признак публикации';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_expand_id IS 'Точка публикации в "Коллекция"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_is_pc_enable IS 'Доступен с ПК';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_is_tablet_enable IS 'Доступен с планшета';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_is_phone_enable IS 'Доступен с телефона';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_report_id IS 'Шаблон BI для дашборда - ID в "Песочнице" или "Отчёты FR"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_report_name IS 'Шаблон BI для дашборда - название в "Песочнице" или "Отчёты FR"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_expand_name IS 'Шаблон BI для дашборда - название в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_fine_bi IS 'Полный путь в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_1 IS 'Место размещения в "Коллекции" или другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_2 IS 'Каталог пути ур.1 в "Коллекции" или "Подразделение ур.2" разработчика для другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_3 IS 'Каталог пути ур.2 в "Коллекции" или "Подразделение ур.3" разработчика для другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_4 IS 'Каталог пути ур.3 в "Коллекции" или "Песочница ур.1"/"Отчёты FR ур.1" разработчика для другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_5 IS 'Каталог пути ур.4 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_6 IS 'Каталог пути ур.5 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_7 IS 'Каталог пути ур.6 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_8 IS 'Каталог пути ур.7 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_9 IS 'Каталог пути ур.8 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.path_dev IS 'Путь в "Песочнице" или "Отчёты FR"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_created_date IS 'Дата монтирования в "Коллекцию"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_update_date IS 'Дата обновления в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sm_web_link IS 'Ссылка URL на отчёт в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_dash_lvl IS 'Уровень дашборда в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.pm_obj_id IS 'id объекта из fine_authority_object';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.pm_obj_parentid IS 'parentid объекта в "Коллекции" из fine_authority_object';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.pm_obj_sortindex IS 'позиция в каталоге объекта в "Коллекции" из fine_authority_object';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.pm_obj_expandtype IS 'тип объекта в "Коллекции" из fine_authority_object';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.dm_publish_name IS 'Пользователь, опубликовавший дашборд';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.dm_publish_login IS 'Логин пользователя, опубликовавшего дашборд';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.dm_publish_user_id IS 'ID пользователя, опубликовавшего дашборд';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id IS 'Полный путь id в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_1 IS 'id каталога пути ур.1 в "Коллекции" или "Подразделение ур.2" разработчика для другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_2 IS 'id каталога пути ур.2 в "Коллекции" или "Подразделение ур.3" разработчика для другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_3 IS 'id каталога пути ур.3 в "Коллекции" или "Песочница ур.1"/"Отчёты FR ур.1" разработчика для другое';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_4 IS 'id каталога пути ур.4 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_5 IS 'id каталога пути ур.5 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_6 IS 'id каталога пути ур.6 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_7 IS 'id каталога пути ур.7 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_8 IS 'id каталога пути ур.8 в "Коллекции"';
COMMENT ON COLUMN public.z11_ui_dir4rep_hierarhy.sd_path_id_9 IS 'id каталога пути ур.9 в "Коллекции"';

--
