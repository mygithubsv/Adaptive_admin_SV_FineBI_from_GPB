--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_schedule_task_hist (
	start_task_date date NULL, -- дата старта задания рассылки
	start_task_dt timestamp NULL, -- время старта задания рассылки
	end_task timestamp NULL, -- дата окончания задания рассылки
	duration_time interval NULL, -- длительность рассылки
	duration_sec numeric NULL, -- длительность рассылки, секунд
	taskconditiontype text NULL, -- условия рассылки
	type_task text NULL, -- тип рассылки
	templatename text NULL, -- имя шаблона
	taskname varchar(255) NULL, -- название рассылки
	id varchar(255) NULL, -- id рассылки
	is_error int4 NULL, -- признак ошибки
	is_enable text NULL, -- состояние рассылки
	calculationjobcount int4 NULL, -- количество запусков этапа вычислений данных
	userresultjobcount int4 NULL, -- количество запусков этапа выводов результатов пользователю
	commonresultjobcount int4 NULL, -- количество запусков этапа отправки результатов
	restartcount int4 NULL, -- количество рестартов
	stage1_name text NULL, -- название: этап рассылки 1
	stage2_name text NULL, -- название: этап рассылки 2
	stage3_name text NULL, -- название: этап рассылки 3
	stage4_name text NULL, -- название: этап рассылки 4
	stage1_status int4 NULL, -- статус: этап рассылки 1
	stage2_status int4 NULL, -- статус: этап рассылки 2
	stage3_status int4 NULL, -- статус: этап рассылки 3
	stage4_status int4 NULL, -- статус: этап рассылки 4
	stage1_endtime timestamp NULL, -- окончание: этап рассылки 1
	stage2_endtime timestamp NULL, -- окончание: этап рассылки 2
	stage3_endtime timestamp NULL, -- окончание: этап рассылки 3
	stage4_endtime timestamp NULL, -- окончание: этап рассылки 4
	stage1_restartcount int4 NULL, -- рестарты: этап рассылки 1
	stage2_restartcount int4 NULL, -- рестарты: этап рассылки 2
	stage3_restartcount int4 NULL, -- рестарты: этап рассылки 3
	stage4_restartcount int4 NULL, -- рестарты: этап рассылки 4
	taskid varchar(255) NULL, -- id задачи рассылки
	tasklog text NULL, -- лог задачи рассылки
	templatepath varchar(1000) NULL, -- путь к шаблону
	creator varchar(255) NULL, -- создатель рассылки
	taskdescription varchar(1000) NULL, -- описание рассылки
	taskstate int4 NULL, -- состояние рассылки
	tasktype int4 NULL, -- тип рассылки
	recipient_usertype text NULL, -- тип получателей результата
	recipient_departmentstr text NULL, -- перечень подразделений получателей результата
	recipient_customrolestr text NULL, -- перечень ролей получателей результата
	recipient_platformuserstr text NULL, -- перечень УЗ пользователей получателей результата
	scheduler_triggertype text NULL, -- планировщик: тип триггера
	scheduler_starttime text NULL, -- планировщик: время старта
	scheduler_endtime text NULL, -- планировщик: время окончания
	scheduler_starttype text NULL, -- планировщик: тип старта
	scheduler_endtype text NULL, -- планировщик: тип окончания
	scheduler_repeatcount text NULL -- планировщик: количество повторов
);
COMMENT ON TABLE public.z01_schedule_task_hist IS 'ОМ: лог рассылок';
COMMENT ON COLUMN public.z01_schedule_task_hist.start_task_date IS 'дата старта задания рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.start_task_dt IS 'время старта задания рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.end_task IS 'дата окончания задания рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.duration_time IS 'длительность рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.duration_sec IS 'длительность рассылки, секунд';
COMMENT ON COLUMN public.z01_schedule_task_hist.taskconditiontype IS 'условия рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.type_task IS 'тип рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.templatename IS 'имя шаблона';
COMMENT ON COLUMN public.z01_schedule_task_hist.taskname IS 'название рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.id IS 'id рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.is_error IS 'признак ошибки';
COMMENT ON COLUMN public.z01_schedule_task_hist.is_enable IS 'состояние рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.calculationjobcount IS 'количество запусков этапа вычислений данных';
COMMENT ON COLUMN public.z01_schedule_task_hist.userresultjobcount IS 'количество запусков этапа выводов результатов пользователю';
COMMENT ON COLUMN public.z01_schedule_task_hist.commonresultjobcount IS 'количество запусков этапа отправки результатов';
COMMENT ON COLUMN public.z01_schedule_task_hist.restartcount IS 'количество рестартов';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage1_name IS 'название: этап рассылки 1';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage2_name IS 'название: этап рассылки 2';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage3_name IS 'название: этап рассылки 3';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage4_name IS 'название: этап рассылки 4';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage1_status IS 'статус: этап рассылки 1';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage2_status IS 'статус: этап рассылки 2';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage3_status IS 'статус: этап рассылки 3';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage4_status IS 'статус: этап рассылки 4';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage1_endtime IS 'окончание: этап рассылки 1';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage2_endtime IS 'окончание: этап рассылки 2';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage3_endtime IS 'окончание: этап рассылки 3';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage4_endtime IS 'окончание: этап рассылки 4';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage1_restartcount IS 'рестарты: этап рассылки 1';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage2_restartcount IS 'рестарты: этап рассылки 2';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage3_restartcount IS 'рестарты: этап рассылки 3';
COMMENT ON COLUMN public.z01_schedule_task_hist.stage4_restartcount IS 'рестарты: этап рассылки 4';
COMMENT ON COLUMN public.z01_schedule_task_hist.taskid IS 'id задачи рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.tasklog IS 'лог задачи рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.templatepath IS 'путь к шаблону';
COMMENT ON COLUMN public.z01_schedule_task_hist.creator IS 'создатель рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.taskdescription IS 'описание рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.taskstate IS 'состояние рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.tasktype IS 'тип рассылки';
COMMENT ON COLUMN public.z01_schedule_task_hist.recipient_usertype IS 'тип получателей результата';
COMMENT ON COLUMN public.z01_schedule_task_hist.recipient_departmentstr IS 'перечень подразделений получателей результата';
COMMENT ON COLUMN public.z01_schedule_task_hist.recipient_customrolestr IS 'перечень ролей получателей результата';
COMMENT ON COLUMN public.z01_schedule_task_hist.recipient_platformuserstr IS 'перечень УЗ пользователей получателей результата';
COMMENT ON COLUMN public.z01_schedule_task_hist.scheduler_triggertype IS 'планировщик: тип триггера';
COMMENT ON COLUMN public.z01_schedule_task_hist.scheduler_starttime IS 'планировщик: время старта';
COMMENT ON COLUMN public.z01_schedule_task_hist.scheduler_endtime IS 'планировщик: время окончания';
COMMENT ON COLUMN public.z01_schedule_task_hist.scheduler_starttype IS 'планировщик: тип старта';
COMMENT ON COLUMN public.z01_schedule_task_hist.scheduler_endtype IS 'планировщик: тип окончания';
COMMENT ON COLUMN public.z01_schedule_task_hist.scheduler_repeatcount IS 'планировщик: количество повторов';

--
