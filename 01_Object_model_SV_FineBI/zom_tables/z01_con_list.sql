--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_con_list (
	cm_con_name_ui text NULL, -- Название подключения в UI
	cm_con_creator_id text NULL, -- ID создателя подключения
	cm_con_creator_name varchar(255) NULL, -- Создатель подключения
	cm_con_database_type text NULL, -- Тип СУБД или источника данных (like swift)
	cd_con_host text NULL, -- Хост БД
	cd_con_port text NULL, -- Порт БД
	cm_con_db text NULL, -- Название БД
	cm_con_login text NULL, -- УЗ БД
	cm_con_url text NULL, -- строка URL для подключения
	cd_lost_con_name text NULL, -- название потерянного соединения из таблицы базовых сообщений
	cd_lost_con_dtime timestamp NULL, -- последнее время наличия подключения в списке потерянных
	cd_lost_con_intrvl_hour_int numeric NULL, -- давность наличия подключения в списке потерянных в часах
	cd_lost_con_intrvl_txt text NULL, -- давность наличия подключения в списке потерянных в формате чч:мм
	cd_cnt_lost_conn_3day int8 NULL, -- количество записей о потерянном подключении за 3 последних дня
	cm_ssh_ip text NULL, -- IP для SSH
	cm_ssh_port text NULL, -- Порт для SSH
	cm_ssh_user text NULL, -- УЗ для SSH
	cm_ssh_key text NULL -- Название файла ключа SSH
);
COMMENT ON TABLE public.z01_con_list IS 'ОМ: объекты: подключения: список';
COMMENT ON COLUMN public.z01_con_list.cm_con_name_ui IS 'Название подключения в UI';
COMMENT ON COLUMN public.z01_con_list.cm_con_creator_id IS 'ID создателя подключения';
COMMENT ON COLUMN public.z01_con_list.cm_con_creator_name IS 'Создатель подключения';
COMMENT ON COLUMN public.z01_con_list.cm_con_database_type IS 'Тип СУБД или источника данных (like swift)';
COMMENT ON COLUMN public.z01_con_list.cd_con_host IS 'Хост БД';
COMMENT ON COLUMN public.z01_con_list.cd_con_port IS 'Порт БД';
COMMENT ON COLUMN public.z01_con_list.cm_con_db IS 'Название БД';
COMMENT ON COLUMN public.z01_con_list.cm_con_login IS 'УЗ БД';
COMMENT ON COLUMN public.z01_con_list.cm_con_url IS 'строка URL для подключения';
COMMENT ON COLUMN public.z01_con_list.cd_lost_con_name IS 'название потерянного соединения из таблицы базовых сообщений';
COMMENT ON COLUMN public.z01_con_list.cd_lost_con_dtime IS 'последнее время наличия подключения в списке потерянных';
COMMENT ON COLUMN public.z01_con_list.cd_lost_con_intrvl_hour_int IS 'давность наличия подключения в списке потерянных в часах';
COMMENT ON COLUMN public.z01_con_list.cd_lost_con_intrvl_txt IS 'давность наличия подключения в списке потерянных в формате чч:мм';
COMMENT ON COLUMN public.z01_con_list.cd_cnt_lost_conn_3day IS 'количество записей о потерянном подключении за 3 последних дня';
COMMENT ON COLUMN public.z01_con_list.cm_ssh_ip IS 'IP для SSH';
COMMENT ON COLUMN public.z01_con_list.cm_ssh_port IS 'Порт для SSH';
COMMENT ON COLUMN public.z01_con_list.cm_ssh_user IS 'УЗ для SSH';
COMMENT ON COLUMN public.z01_con_list.cm_ssh_key IS 'Название файла ключа SSH';

--
