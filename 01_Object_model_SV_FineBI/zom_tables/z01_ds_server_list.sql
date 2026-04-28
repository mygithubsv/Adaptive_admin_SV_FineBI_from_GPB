--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_server_list (
	"name" text NULL, -- название датасета
	dss_type text NULL, -- тип датасета
	dss_con_name text NULL, -- подключение
	dss_obj text NULL -- текст запроса с подключения
);
COMMENT ON TABLE public.z01_ds_server_list IS 'ОМ: объекты: датасеты: серверные датасеты';
COMMENT ON COLUMN public.z01_ds_server_list."name" IS 'название датасета';
COMMENT ON COLUMN public.z01_ds_server_list.dss_type IS 'тип датасета';
COMMENT ON COLUMN public.z01_ds_server_list.dss_con_name IS 'подключение';
COMMENT ON COLUMN public.z01_ds_server_list.dss_obj IS 'текст запроса с подключения';

--
