--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_om_plan (
	group_num int4 NULL, -- группа функций
	sub_group_num int4 NULL, -- порядок выполнения в группе функций
	sub_group_name varchar(50) NULL, -- название подгруппы функций (не связан напрямую с sub_group_name)
	func_name varchar(50) NULL, -- имя функции
	is_enable int4 NULL, -- признак активности расчёта функции
	group_name varchar NULL -- название группы функции
);
COMMENT ON TABLE public.z01_om_plan IS 'ОМ: список функций сборки';
COMMENT ON COLUMN public.z01_om_plan.group_num IS 'группа функций';
COMMENT ON COLUMN public.z01_om_plan.sub_group_num IS 'порядок выполнения в группе функций';
COMMENT ON COLUMN public.z01_om_plan.sub_group_name IS 'название подгруппы функций (не связан напрямую с sub_group_name)';
COMMENT ON COLUMN public.z01_om_plan.func_name IS 'имя функции';
COMMENT ON COLUMN public.z01_om_plan.is_enable IS 'признак активности расчёта функции';
COMMENT ON COLUMN public.z01_om_plan.group_name IS 'название группы функции';

--
