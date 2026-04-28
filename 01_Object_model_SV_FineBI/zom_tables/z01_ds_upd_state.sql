--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_ds_upd_state (
	dsm_id text NULL, -- ID датасета (ДС)
	dsm_con_type text NULL, -- Тип обновления
	dsm_data_update timestamp NULL, -- Дата обновления ДС
	dsm_config_update timestamp NULL, -- Дата изменения ДС
	dsm_last_update timestamp NULL, -- ?Дата последнего изменения
	dsm_cur_update timestamp NULL, -- ?Дата текущего измнения
	dsm_source_version int4 NULL, -- Версия источника
	dsm_update_type text NULL, -- Тип обновления
	dsm_upd_mode text NULL, -- ?Режим обновления
	dsm_ent_valid text NULL, -- Проверка валидности
	dsm_ent_active text NULL, -- Проверка активности
	dsm_ent_extract text NULL, -- Признак экстракции
	dsm_ent_inherit text NULL -- Признак наследования
);
COMMENT ON TABLE public.z01_ds_upd_state IS 'ОМ: объекты: датасеты: состояния (изменение, обновление, настройки)';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_id IS 'ID датасета (ДС)';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_con_type IS 'Тип обновления';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_data_update IS 'Дата обновления ДС';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_config_update IS 'Дата изменения ДС';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_last_update IS '?Дата последнего изменения';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_cur_update IS '?Дата текущего измнения';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_source_version IS 'Версия источника';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_update_type IS 'Тип обновления';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_upd_mode IS '?Режим обновления';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_ent_valid IS 'Проверка валидности';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_ent_active IS 'Проверка активности';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_ent_extract IS 'Признак экстракции';
COMMENT ON COLUMN public.z01_ds_upd_state.dsm_ent_inherit IS 'Признак наследования';

--
