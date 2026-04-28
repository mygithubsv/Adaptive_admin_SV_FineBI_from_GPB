--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_log_msg_ui (
	createtime timestamp NULL, -- дата создания
	username varchar(255) NULL, -- УЗ ПО
	realname varchar(255) NULL, -- ФИО УЗ ПО
	cat text NULL, -- категория сообщения
	readed int4 NULL, -- признак прочтения
	toasted int4 NULL, -- признак всплывающего сообщения
	is_auto_read int4 NULL, -- опция автоматического прочтения
	is_auto_untoasted int4 NULL, -- опция автоскрытия всплывающего сообщения
	cat_value int4 NULL, -- степень важности сообщения
	url varchar(65536) NULL, -- URL
	message varchar(65536) NULL -- сообщение
);
COMMENT ON TABLE public.z01_log_msg_ui IS 'Сообщение платформы на администраторов по категориям';
COMMENT ON COLUMN public.z01_log_msg_ui.createtime IS 'дата создания';
COMMENT ON COLUMN public.z01_log_msg_ui.username IS 'УЗ ПО';
COMMENT ON COLUMN public.z01_log_msg_ui.realname IS 'ФИО УЗ ПО';
COMMENT ON COLUMN public.z01_log_msg_ui.cat IS 'категория сообщения';
COMMENT ON COLUMN public.z01_log_msg_ui.readed IS 'признак прочтения';
COMMENT ON COLUMN public.z01_log_msg_ui.toasted IS 'признак всплывающего сообщения';
COMMENT ON COLUMN public.z01_log_msg_ui.is_auto_read IS 'опция автоматического прочтения';
COMMENT ON COLUMN public.z01_log_msg_ui.is_auto_untoasted IS 'опция автоскрытия всплывающего сообщения';
COMMENT ON COLUMN public.z01_log_msg_ui.cat_value IS 'степень важности сообщения';
COMMENT ON COLUMN public.z01_log_msg_ui.url IS 'URL';
COMMENT ON COLUMN public.z01_log_msg_ui.message IS 'сообщение';

--
