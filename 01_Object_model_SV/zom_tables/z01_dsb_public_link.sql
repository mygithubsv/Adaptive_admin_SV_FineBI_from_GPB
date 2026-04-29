--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_dsb_public_link (
	dm_report_id text NULL, -- ID дашборда
	dm_username varchar(255) NULL, -- УЗ, создатель публичной ссылки
	dm_user_id text NULL, -- ID УЗ, создатель публичной ссылки
	dm_link_id text NULL, -- Публичная ссылка на дашборд
	dm_is_shared int4 NULL, -- Признак: 1 - активирована ссылка
	dm_is_pwprotect int4 NULL, -- Признак: 1 - защищен паролем
	dm_deadline timestamp NULL -- Дата окончания публикации
);
COMMENT ON TABLE public.z01_dsb_public_link IS 'ОМ: объекты: дашборды: публичные ссылки';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_report_id IS 'ID дашборда';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_username IS 'УЗ, создатель публичной ссылки';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_user_id IS 'ID УЗ, создатель публичной ссылки';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_link_id IS 'Публичная ссылка на дашборд';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_is_shared IS 'Признак: 1 - активирована ссылка';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_is_pwprotect IS 'Признак: 1 - защищен паролем';
COMMENT ON COLUMN public.z01_dsb_public_link.dm_deadline IS 'Дата окончания публикации';

--
