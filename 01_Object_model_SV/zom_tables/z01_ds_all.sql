--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_all (
	dsm_table_id text NULL, -- id датасета
	dsm_table_name_uniq text NULL, -- уникальный текстовый id датасета
	dsm_table_name_ui text NULL, -- название таблицы ДС в UI ПО
	dsm_driver_type text NULL, -- драйвер ДС
	dsm_name text NULL, -- название ДС
	dsm_config_created timestamp NULL, -- дата создания ДС
	dsm_db_name text NULL, -- название БД
	dsm_con_name text NULL, -- название подключения
	dsm_creator_id text NULL, -- id создателя ДС
	dsm_creator_name varchar(255) NULL, -- логин создателя ДС
	dsm_alias_name text NULL, -- название таблицы в UI ПО
	dsm_tablename text NULL, -- название таблицы
	dsm_db_tablename text NULL, -- таблица ДС
	dsm_file_name text NULL, -- файл ДС
	dsm_origin_source text NULL, -- источник ДС
	dsm_ecf_content text NULL, -- json с параметрами ДС
	dsm_sql text NULL, -- полное SQL выражение
	dsd_sql_preview text NULL, -- превью SQL выражения (опущен список полей select)
	dsd_len_sqltext int4 NULL, -- длина SQL выражения
	dsd_path_ds text NULL, -- полный путь в "Источники"
	dsm_level int4 NULL, -- уровень вложенности в "Источники"
	dsd_e1_name text NULL, -- путь в "Источники" 1
	dsd_e1_pkg_ds_id text NULL, -- путь id в "Источники" 1
	dsd_e2_name text NULL, -- путь в "Источники" 2
	dsd_e2_pkg_ds_id text NULL, -- путь id в "Источники" 2
	dsd_e3_name text NULL, -- путь в "Источники" 3
	dsd_e3_pkg_ds_id text NULL, -- путь id в "Источники" 3
	dsd_e4_name text NULL, -- путь в "Источники" 4
	dsd_e4_pkg_ds_id text NULL, -- путь id в "Источники" 4
	dsd_e5_name text NULL, -- путь в "Источники" 5
	dsd_e5_pkg_ds_id text NULL, -- путь id в "Источники" 5
	dsd_e6_name text NULL, -- путь в "Источники" 6
	dsd_e6_pkg_ds_id text NULL, -- путь id в "Источники" 6
	dsd_e7_name text NULL, -- путь в "Источники" 7
	dsd_e7_pkg_ds_id text NULL, -- путь id в "Источники" 7
	dsd_e8_name text NULL, -- путь в "Источники" 8
	dsd_e8_pkg_ds_id text NULL, -- путь id в "Источники" 8
	dsd_e9_name text NULL, -- путь в "Источники" 9
	dsd_e9_pkg_ds_id text NULL, -- путь id в "Источники" 9
	dsd_e10_name text NULL, -- путь в "Источники" 10
	dsd_e10_pkg_ds_id text NULL, -- путь id в "Источники" 10
	dsd_path_ds_id text NULL, -- полный путь id в "Источники"
	dsm_con_type text NULL, -- тип подключения
	dsm_data_update timestamp NULL, -- последнее обновление данных ДС
	dsm_config_update timestamp NULL, -- последнее редактирование ДС
	dsm_last_update timestamp NULL, -- ?последнее обновление ДС
	dsm_cur_update timestamp NULL, -- ?текущее редактирование ДС
	dsm_source_version int4 NULL, -- версия источника
	dsm_update_type text NULL, -- тип обновления
	dsm_upd_mode text NULL, -- ?
	dsm_ent_valid text NULL, -- признак валидности ДС
	dsm_ent_active text NULL, -- признак активного ДС
	dsm_ent_extract text NULL, -- признак экстракта ДС
	dsm_ent_inherit text NULL, -- признак наследования ДС
	dsm_load_type text NULL, -- тип загрузки ДС
	dsd_is_corr int4 NULL, -- корректность ДС
	dsd_age_success_cat int4 NULL, -- давность успешного обновления ДС, дней
	dsd_err_cat int4 NULL, -- категория ошибки
	dsd_cnt_wrong int8 NULL, -- количество ошибок загрузок ДС
	dsd_cnt_upd int8 NULL, -- количество загрузок ДС
	dsd_perc_wrong numeric NULL, -- процент ошибок загрузок ДС
	dsd_last_success timestamp NULL, -- дата последней успешной загрузки ДС
	dsd_last_wrong timestamp NULL, -- дата последней ошибки загрузки ДС
	dsd_delta_hours_scs numeric NULL, -- давность успешного обновления ДС, часов
	columncount int8 NULL, -- число столбцов
	totalcount int8 NULL, -- число строк
	ds_elems int8 NULL, -- элементов ДС
	ds_elems_calc int8 NULL, -- вычисляемых элементов ДС
	cat_size_ds int4 NULL, -- категория размера ДС (количество элементов ДС)
	etlflow text NULL, -- полное описание последовательности ETL
	etlflow_short text NULL, -- сокращенное описание последовательности ETL
	cnt_ds_ops int4 NULL, -- количество операций в ETL
	cnt_ds_select int4 NULL, -- количество операций в ETL: выбор датасета
	cnt_ds_join int4 NULL, -- количество операций в ETL: объединение датасетов
	cnt_ds_addcolumn int4 NULL, -- количество операций в ETL: добавление поля
	cnt_ds_fieldsetting int4 NULL, -- количество операций в ETL: переименование поля
	cnt_ds_fieldtranstype int4 NULL, -- количество операций в ETL: конверсия поля
	cnt_ds_filter int4 NULL, -- количество операций в ETL: фильтрация
	cnt_ds_group int4 NULL, -- количество операций в ETL: агрегация группировкой
	upd_taskname varchar(255) NULL, -- название задачи обновления ДС
	upd_loadtype varchar(255) NULL, -- тип загрузки ДС
	upd_updatetype varchar(255) NULL, -- тип обновления ДС
	upd_starttime timestamp NULL, -- старт обновления
	upd_endtime timestamp NULL, -- окончание обновления
	upd_totaltime_sec int8 NULL, -- полное время обновления
	upd_opentime_sec int8 NULL, -- время этапа обновления OPEN
	upd_writetime_sec int8 NULL, -- время этапа обновления WRITE
	upd_jdbctime_sec int8 NULL, -- время этапа обновления JDBC
	upd_statetype varchar(255) NULL, -- состояние обновления
	upd_rolename varchar(255) NULL, -- логин УЗ, запустившей обновление
	upd_runningresult varchar(255) NULL, -- результат обновления
	upd_triggertype varchar(255) NULL, -- тип вызова обновления
	source_db_table_name text NULL -- источник данных таблицы
);
COMMENT ON TABLE public.z01_ds_all IS 'ОМ: объекты: датасеты: обобщённое представление';
COMMENT ON COLUMN public.z01_ds_all.dsm_table_id IS 'id датасета';
COMMENT ON COLUMN public.z01_ds_all.dsm_table_name_uniq IS 'уникальный текстовый id датасета';
COMMENT ON COLUMN public.z01_ds_all.dsm_table_name_ui IS 'название таблицы ДС в UI ПО';
COMMENT ON COLUMN public.z01_ds_all.dsm_driver_type IS 'драйвер ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_name IS 'название ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_config_created IS 'дата создания ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_db_name IS 'название БД';
COMMENT ON COLUMN public.z01_ds_all.dsm_con_name IS 'название подключения';
COMMENT ON COLUMN public.z01_ds_all.dsm_creator_id IS 'id создателя ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_creator_name IS 'логин создателя ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_alias_name IS 'название таблицы в UI ПО';
COMMENT ON COLUMN public.z01_ds_all.dsm_tablename IS 'название таблицы';
COMMENT ON COLUMN public.z01_ds_all.dsm_db_tablename IS 'таблица ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_file_name IS 'файл ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_origin_source IS 'источник ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_ecf_content IS 'json с параметрами ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_sql IS 'полное SQL выражение';
COMMENT ON COLUMN public.z01_ds_all.dsd_sql_preview IS 'превью SQL выражения (опущен список полей select)';
COMMENT ON COLUMN public.z01_ds_all.dsd_len_sqltext IS 'длина SQL выражения';
COMMENT ON COLUMN public.z01_ds_all.dsd_path_ds IS 'полный путь в "Источники"';
COMMENT ON COLUMN public.z01_ds_all.dsm_level IS 'уровень вложенности в "Источники"';
COMMENT ON COLUMN public.z01_ds_all.dsd_e1_name IS 'путь в "Источники" 1';
COMMENT ON COLUMN public.z01_ds_all.dsd_e1_pkg_ds_id IS 'путь id в "Источники" 1';
COMMENT ON COLUMN public.z01_ds_all.dsd_e2_name IS 'путь в "Источники" 2';
COMMENT ON COLUMN public.z01_ds_all.dsd_e2_pkg_ds_id IS 'путь id в "Источники" 2';
COMMENT ON COLUMN public.z01_ds_all.dsd_e3_name IS 'путь в "Источники" 3';
COMMENT ON COLUMN public.z01_ds_all.dsd_e3_pkg_ds_id IS 'путь id в "Источники" 3';
COMMENT ON COLUMN public.z01_ds_all.dsd_e4_name IS 'путь в "Источники" 4';
COMMENT ON COLUMN public.z01_ds_all.dsd_e4_pkg_ds_id IS 'путь id в "Источники" 4';
COMMENT ON COLUMN public.z01_ds_all.dsd_e5_name IS 'путь в "Источники" 5';
COMMENT ON COLUMN public.z01_ds_all.dsd_e5_pkg_ds_id IS 'путь id в "Источники" 5';
COMMENT ON COLUMN public.z01_ds_all.dsd_e6_name IS 'путь в "Источники" 6';
COMMENT ON COLUMN public.z01_ds_all.dsd_e6_pkg_ds_id IS 'путь id в "Источники" 6';
COMMENT ON COLUMN public.z01_ds_all.dsd_e7_name IS 'путь в "Источники" 7';
COMMENT ON COLUMN public.z01_ds_all.dsd_e7_pkg_ds_id IS 'путь id в "Источники" 7';
COMMENT ON COLUMN public.z01_ds_all.dsd_e8_name IS 'путь в "Источники" 8';
COMMENT ON COLUMN public.z01_ds_all.dsd_e8_pkg_ds_id IS 'путь id в "Источники" 8';
COMMENT ON COLUMN public.z01_ds_all.dsd_e9_name IS 'путь в "Источники" 9';
COMMENT ON COLUMN public.z01_ds_all.dsd_e9_pkg_ds_id IS 'путь id в "Источники" 9';
COMMENT ON COLUMN public.z01_ds_all.dsd_e10_name IS 'путь в "Источники" 10';
COMMENT ON COLUMN public.z01_ds_all.dsd_e10_pkg_ds_id IS 'путь id в "Источники" 10';
COMMENT ON COLUMN public.z01_ds_all.dsd_path_ds_id IS 'полный путь id в "Источники"';
COMMENT ON COLUMN public.z01_ds_all.dsm_con_type IS 'тип подключения';
COMMENT ON COLUMN public.z01_ds_all.dsm_data_update IS 'последнее обновление данных ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_config_update IS 'последнее редактирование ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_last_update IS '?последнее обновление ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_cur_update IS '?текущее редактирование ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_source_version IS 'версия источника';
COMMENT ON COLUMN public.z01_ds_all.dsm_update_type IS 'тип обновления';
COMMENT ON COLUMN public.z01_ds_all.dsm_upd_mode IS '?';
COMMENT ON COLUMN public.z01_ds_all.dsm_ent_valid IS 'признак валидности ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_ent_active IS 'признак активного ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_ent_extract IS 'признак экстракта ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_ent_inherit IS 'признак наследования ДС';
COMMENT ON COLUMN public.z01_ds_all.dsm_load_type IS 'тип загрузки ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_is_corr IS 'корректность ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_age_success_cat IS 'давность успешного обновления ДС, дней';
COMMENT ON COLUMN public.z01_ds_all.dsd_err_cat IS 'категория ошибки';
COMMENT ON COLUMN public.z01_ds_all.dsd_cnt_wrong IS 'количество ошибок загрузок ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_cnt_upd IS 'количество загрузок ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_perc_wrong IS 'процент ошибок загрузок ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_last_success IS 'дата последней успешной загрузки ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_last_wrong IS 'дата последней ошибки загрузки ДС';
COMMENT ON COLUMN public.z01_ds_all.dsd_delta_hours_scs IS 'давность успешного обновления ДС, часов';
COMMENT ON COLUMN public.z01_ds_all.columncount IS 'число столбцов';
COMMENT ON COLUMN public.z01_ds_all.totalcount IS 'число строк';
COMMENT ON COLUMN public.z01_ds_all.ds_elems IS 'элементов ДС';
COMMENT ON COLUMN public.z01_ds_all.ds_elems_calc IS 'вычисляемых элементов ДС';
COMMENT ON COLUMN public.z01_ds_all.cat_size_ds IS 'категория размера ДС (количество элементов ДС)';
COMMENT ON COLUMN public.z01_ds_all.etlflow IS 'полное описание последовательности ETL';
COMMENT ON COLUMN public.z01_ds_all.etlflow_short IS 'сокращенное описание последовательности ETL';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_ops IS 'количество операций в ETL';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_select IS 'количество операций в ETL: выбор датасета';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_join IS 'количество операций в ETL: объединение датасетов';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_addcolumn IS 'количество операций в ETL: добавление поля';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_fieldsetting IS 'количество операций в ETL: переименование поля';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_fieldtranstype IS 'количество операций в ETL: конверсия поля';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_filter IS 'количество операций в ETL: фильтрация';
COMMENT ON COLUMN public.z01_ds_all.cnt_ds_group IS 'количество операций в ETL: агрегация группировкой';
COMMENT ON COLUMN public.z01_ds_all.upd_taskname IS 'название задачи обновления ДС';
COMMENT ON COLUMN public.z01_ds_all.upd_loadtype IS 'тип загрузки ДС';
COMMENT ON COLUMN public.z01_ds_all.upd_updatetype IS 'тип обновления ДС';
COMMENT ON COLUMN public.z01_ds_all.upd_starttime IS 'старт обновления';
COMMENT ON COLUMN public.z01_ds_all.upd_endtime IS 'окончание обновления';
COMMENT ON COLUMN public.z01_ds_all.upd_totaltime_sec IS 'полное время обновления';
COMMENT ON COLUMN public.z01_ds_all.upd_opentime_sec IS 'время этапа обновления OPEN';
COMMENT ON COLUMN public.z01_ds_all.upd_writetime_sec IS 'время этапа обновления WRITE';
COMMENT ON COLUMN public.z01_ds_all.upd_jdbctime_sec IS 'время этапа обновления JDBC';
COMMENT ON COLUMN public.z01_ds_all.upd_statetype IS 'состояние обновления';
COMMENT ON COLUMN public.z01_ds_all.upd_rolename IS 'логин УЗ, запустившей обновление';
COMMENT ON COLUMN public.z01_ds_all.upd_runningresult IS 'результат обновления';
COMMENT ON COLUMN public.z01_ds_all.upd_triggertype IS 'тип вызова обновления';
COMMENT ON COLUMN public.z01_ds_all.source_db_table_name IS 'источник данных таблицы';

--
