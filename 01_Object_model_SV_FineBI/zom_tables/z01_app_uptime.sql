--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_app_uptime (
	biversion text NULL, -- Версия ПО
	startupuser varchar(255) NULL, -- УЗ, сипользуемая при старте ПО
	startuptime_cur timestamp NULL, -- Время начала старта текущего запуска
	startuptime_prev timestamp NULL, -- Время начала старта предыдущего запуска
	uptime numeric NULL, -- Длительность аптайма в часах
	is_restart int4 NULL -- Признак: 1 - рестарт с работой менее 1 часа
);
COMMENT ON TABLE public.z01_app_uptime IS 'ОМ: система: длительность работы после ребута';
COMMENT ON COLUMN public.z01_app_uptime.biversion IS 'Версия ПО';
COMMENT ON COLUMN public.z01_app_uptime.startupuser IS 'УЗ, сипользуемая при старте ПО';
COMMENT ON COLUMN public.z01_app_uptime.startuptime_cur IS 'Время начала старта текущего запуска';
COMMENT ON COLUMN public.z01_app_uptime.startuptime_prev IS 'Время начала старта предыдущего запуска';
COMMENT ON COLUMN public.z01_app_uptime.uptime IS 'Длительность аптайма в часах';
COMMENT ON COLUMN public.z01_app_uptime.is_restart IS 'Признак: 1 - рестарт с работой менее 1 часа';

--
