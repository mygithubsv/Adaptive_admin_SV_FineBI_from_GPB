--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_log_fre_fr_stat (
	executetype int8 NULL, -- код операции из лога
	op_code int4 NULL, -- код операции из словаря
	op_cat varchar(50) NULL, -- операция из словаря
	op_type varchar(64) NULL, -- тип операции из словаря
	module_name varchar(50) NULL, -- название модуля ПО
	time_event_start timestamptz NULL, -- время начала события
	time_event_end timestamp NULL, -- время окончания события
	dur_event interval NULL, -- длительность события
	last_mod_template timestamptz NULL, -- время последнего редактирования шаблона
	ram_size int8 NULL, -- потребление RAM шаблоном (только для FineReport)
	consume_all int8 NULL, -- потребление времени общее
	consume_query int8 NULL, -- потребление времени запросом
	rep_name varchar(255) NULL, -- название дашборда
	rep_file varchar(255) NULL, -- название файла
	reportid varchar(255) NULL, -- id шаблона
	is_error int4 NULL, -- признак ошибки
	err_msg varchar(255) NULL, -- текст ошибки
	node varchar(255) NULL, -- нода
	"source" varchar(255) NULL, -- поле FR
	len_query int4 NULL, -- длина SQL
	cnt_sqlq int4 NULL, -- количество SQL query
	sql_text varchar NULL, -- полный текст SQL
	userid varchar(255) NULL, -- id пользователя
	user_login text NULL, -- логин пользователя
	webresolution_width text NULL, -- ширина разрешения экрана пользователя
	webresolution_height text NULL, -- высота разрешения экрана пользователя
	fullscreen text NULL, -- признак режима полного экрана
	year_quarter date NULL -- квартал года события
);
COMMENT ON TABLE public.z01_log_fre_fr_stat IS 'ОМ: логи: выделенные действия пользователей с контентом платформы с consume из LogDB fine_record_execute';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.executetype IS 'код операции из лога';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.op_code IS 'код операции из словаря';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.op_cat IS 'операция из словаря';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.op_type IS 'тип операции из словаря';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.module_name IS 'название модуля ПО';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.time_event_start IS 'время начала события';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.time_event_end IS 'время окончания события';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.dur_event IS 'длительность события';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.last_mod_template IS 'время последнего редактирования шаблона';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.ram_size IS 'потребление RAM шаблоном (только для FineReport)';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.consume_all IS 'потребление времени общее';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.consume_query IS 'потребление времени запросом';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.rep_name IS 'название дашборда';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.rep_file IS 'название файла';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.reportid IS 'id шаблона';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.is_error IS 'признак ошибки';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.err_msg IS 'текст ошибки';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.node IS 'нода';
COMMENT ON COLUMN public.z01_log_fre_fr_stat."source" IS 'поле FR';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.len_query IS 'длина SQL';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.cnt_sqlq IS 'количество SQL query';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.sql_text IS 'полный текст SQL';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.userid IS 'id пользователя';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.user_login IS 'логин пользователя';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.webresolution_width IS 'ширина разрешения экрана пользователя';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.webresolution_height IS 'высота разрешения экрана пользователя';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.fullscreen IS 'признак режима полного экрана';
COMMENT ON COLUMN public.z01_log_fre_fr_stat.year_quarter IS 'квартал года события';

--
