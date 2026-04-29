--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wid_list (
	wdm_id text NULL, -- ID виджета
	wdm_name text NULL, -- Название виджета
	wdm_creator_id text NULL, -- ID создателя виджета
	wdm_creator varchar(255) NULL, -- Создатель виджета
	wdm_init_time timestamp NULL, -- Время создания виджета
	wdm_update_time timestamp NULL -- Время изменения виджета
);
COMMENT ON TABLE public.z01_wid_list IS 'ОМ: объекты: виджеты: виджеты список';
COMMENT ON COLUMN public.z01_wid_list.wdm_id IS 'ID виджета';
COMMENT ON COLUMN public.z01_wid_list.wdm_name IS 'Название виджета';
COMMENT ON COLUMN public.z01_wid_list.wdm_creator_id IS 'ID создателя виджета';
COMMENT ON COLUMN public.z01_wid_list.wdm_creator IS 'Создатель виджета';
COMMENT ON COLUMN public.z01_wid_list.wdm_init_time IS 'Время создания виджета';
COMMENT ON COLUMN public.z01_wid_list.wdm_update_time IS 'Время изменения виджета';

--
