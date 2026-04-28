--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_upd_struct (
	tablename varchar(255) NULL, -- Название таблицы
	tableid varchar(255) NULL, -- ID таблицы
	columncount int8 NULL, -- Столбцов таблицы
	totalcount int8 NULL, -- Строк таблицы
	ds_elems int8 NULL, -- Элементов таблицы (произведение строк на столбцы)
	ds_elems_calc int8 NULL, -- Расчётных элементов таблицы (произведение строк на столбцы расчётные)
	cat_size_ds int4 NULL, -- Категорирование размера датасета
	etlflow text NULL, -- Последовательность ETL
	etlflow_short text NULL, -- Последовательность ETL (аббревиатуры)
	cnt_ds_ops int4 NULL, -- Операций ETL
	cnt_ds_select int4 NULL, -- Операций Select
	cnt_ds_join int4 NULL, -- Операций Join
	cnt_ds_addcolumn int4 NULL, -- Операций Add Column
	cnt_ds_fieldsetting int4 NULL, -- Операций Field Setting
	cnt_ds_fieldtranstype int4 NULL, -- Операций Field Trans Type
	cnt_ds_filter int4 NULL, -- Операций Filter
	cnt_ds_group int4 NULL, -- Операций Group
	upd_taskname varchar(255) NULL, -- Название задачи обновления
	upd_loadtype varchar(255) NULL, -- Тип загрузки
	upd_updatetype varchar(255) NULL, -- Тип обновления
	upd_starttime timestamp NULL, -- Старт обновления
	upd_endtime timestamp NULL, -- Окончание обновление
	upd_totaltime_sec int8 NULL, -- Длительность обновления, секунд
	upd_opentime_sec int8 NULL, -- Длительность этапа обновления Open, секунд
	upd_writetime_sec int8 NULL, -- Длительность этапа обновления Write, секунд
	upd_jdbctime_sec int8 NULL, -- Длительность этапа обновления JDBC , секунд
	upd_statetype varchar(255) NULL, -- Успешность загрузки
	upd_rolename varchar(255) NULL, -- УЗ, запустившего обновление
	upd_runningresult varchar(255) NULL, -- Полнота обновлений
	upd_triggertype varchar(255) NULL, -- Тип запуска
	upd_rn int8 NULL -- ?ранжирование
);
COMMENT ON TABLE public.z01_ds_upd_struct IS 'ОМ: объекты: датасеты: структура ETL на основании лога обновлений';
COMMENT ON COLUMN public.z01_ds_upd_struct.tablename IS 'Название таблицы';
COMMENT ON COLUMN public.z01_ds_upd_struct.tableid IS 'ID таблицы';
COMMENT ON COLUMN public.z01_ds_upd_struct.columncount IS 'Столбцов таблицы';
COMMENT ON COLUMN public.z01_ds_upd_struct.totalcount IS 'Строк таблицы';
COMMENT ON COLUMN public.z01_ds_upd_struct.ds_elems IS 'Элементов таблицы (произведение строк на столбцы)';
COMMENT ON COLUMN public.z01_ds_upd_struct.ds_elems_calc IS 'Расчётных элементов таблицы (произведение строк на столбцы расчётные)';
COMMENT ON COLUMN public.z01_ds_upd_struct.cat_size_ds IS 'Категорирование размера датасета';
COMMENT ON COLUMN public.z01_ds_upd_struct.etlflow IS 'Последовательность ETL';
COMMENT ON COLUMN public.z01_ds_upd_struct.etlflow_short IS 'Последовательность ETL (аббревиатуры)';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_ops IS 'Операций ETL';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_select IS 'Операций Select';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_join IS 'Операций Join';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_addcolumn IS 'Операций Add Column';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_fieldsetting IS 'Операций Field Setting';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_fieldtranstype IS 'Операций Field Trans Type';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_filter IS 'Операций Filter';
COMMENT ON COLUMN public.z01_ds_upd_struct.cnt_ds_group IS 'Операций Group';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_taskname IS 'Название задачи обновления';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_loadtype IS 'Тип загрузки';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_updatetype IS 'Тип обновления';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_starttime IS 'Старт обновления';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_endtime IS 'Окончание обновление';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_totaltime_sec IS 'Длительность обновления, секунд';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_opentime_sec IS 'Длительность этапа обновления Open, секунд';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_writetime_sec IS 'Длительность этапа обновления Write, секунд';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_jdbctime_sec IS 'Длительность этапа обновления JDBC , секунд';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_statetype IS 'Успешность загрузки';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_rolename IS 'УЗ, запустившего обновление';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_runningresult IS 'Полнота обновлений';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_triggertype IS 'Тип запуска';
COMMENT ON COLUMN public.z01_ds_upd_struct.upd_rn IS '?ранжирование';

--
