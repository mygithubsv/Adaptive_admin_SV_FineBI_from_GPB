--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_proc_log (
	id serial4 NOT NULL, -- id записи, автосчётчик
	"time" timestamp NULL, -- время записи
	login varchar(20) DEFAULT CURRENT_USER NULL, -- УЗ ДБ
	proc_name varchar(100) NULL, -- название функции или процедуры
	is_end int2 NULL, -- признак начала = 0, окончания = 1
	error_msg varchar(100) NULL, -- событие ошибки или дополнительные комментарии к расчёту
	ses_id varchar(14) NULL -- id сессии расчёта (из даты первой вызванной родительской функции)
);
COMMENT ON TABLE public.z01_proc_log IS 'ОМ: таблица логирования запуска функций ОМ';
COMMENT ON COLUMN public.z01_proc_log.id IS 'id записи, автосчётчик';
COMMENT ON COLUMN public.z01_proc_log."time" IS 'время записи';
COMMENT ON COLUMN public.z01_proc_log.login IS 'УЗ ДБ';
COMMENT ON COLUMN public.z01_proc_log.proc_name IS 'название функции или процедуры';
COMMENT ON COLUMN public.z01_proc_log.is_end IS 'признак начала = 0, окончания = 1';
COMMENT ON COLUMN public.z01_proc_log.error_msg IS 'событие ошибки или дополнительные комментарии к расчёту';
COMMENT ON COLUMN public.z01_proc_log.ses_id IS 'id сессии расчёта (из даты первой вызванной родительской функции)';

--
