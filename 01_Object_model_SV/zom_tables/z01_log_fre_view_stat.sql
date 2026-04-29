--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_log_fre_view_stat (
	executetype int8 NULL, -- код операции из лога
	op_type varchar(64) NULL, -- тип операции из словаря
	module_name varchar(50) NULL, -- название модуля ПО
	time_view_start timestamptz NULL, -- время просмотра
	hour_view numeric NULL, -- час просмотра
	consume_all int8 NULL, -- потребляемое действием время
	rep_name varchar(255) NULL, -- название шаблона
	rep_file varchar(255) NULL, -- название файла
	reportid varchar(255) NULL, -- id шаблона
	is_error int4 NULL, -- признак ошибки
	err_msg varchar(255) NULL, -- сообщение ошибки
	node varchar(255) NULL, -- нода
	userid varchar(255) NULL, -- id пользователя
	user_login text NULL -- логин пользователя
);
COMMENT ON TABLE public.z01_log_fre_view_stat IS 'ОМ: логи: почасовой просмотр дашбордов (FineBI, cpt, frm)';
COMMENT ON COLUMN public.z01_log_fre_view_stat.executetype IS 'код операции из лога';
COMMENT ON COLUMN public.z01_log_fre_view_stat.op_type IS 'тип операции из словаря';
COMMENT ON COLUMN public.z01_log_fre_view_stat.module_name IS 'название модуля ПО';
COMMENT ON COLUMN public.z01_log_fre_view_stat.time_view_start IS 'время просмотра';
COMMENT ON COLUMN public.z01_log_fre_view_stat.hour_view IS 'час просмотра';
COMMENT ON COLUMN public.z01_log_fre_view_stat.consume_all IS 'потребляемое действием время';
COMMENT ON COLUMN public.z01_log_fre_view_stat.rep_name IS 'название шаблона';
COMMENT ON COLUMN public.z01_log_fre_view_stat.rep_file IS 'название файла';
COMMENT ON COLUMN public.z01_log_fre_view_stat.reportid IS 'id шаблона';
COMMENT ON COLUMN public.z01_log_fre_view_stat.is_error IS 'признак ошибки';
COMMENT ON COLUMN public.z01_log_fre_view_stat.err_msg IS 'сообщение ошибки';
COMMENT ON COLUMN public.z01_log_fre_view_stat.node IS 'нода';
COMMENT ON COLUMN public.z01_log_fre_view_stat.userid IS 'id пользователя';
COMMENT ON COLUMN public.z01_log_fre_view_stat.user_login IS 'логин пользователя';

--
