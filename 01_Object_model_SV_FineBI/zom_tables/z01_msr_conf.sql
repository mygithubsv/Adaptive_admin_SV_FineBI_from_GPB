--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_msr_conf (
	dsm_msr_id text NULL, -- id меры
	dsm_msr_name text NULL, -- имя меры
	dsm_msr_type_data text NULL, -- тип данных меры
	dsm_msr_type text NULL, -- тип меры
	dsm_msr_model text NULL, -- ?
	dsm_msr_calc_type text NULL, -- ?
	dsm_msr_calc_value text NULL, -- ?
	dsm_msr_calc_aggregate text NULL, -- ?
	dsm_cnt_msr_conf_id int4 NULL, -- количество в формуле выражений с id
	dsm_cnt_msr_conf_switch int4 NULL, -- количество в формуле выражений с switch
	dsm_cnt_msr_conf_def int4 NULL, -- количество в формуле выражений с def
	dsm_cnt_msr_conf_def_add int4 NULL, -- количество в формуле выражений с def_add
	dsm_cnt_msr_conf_def_sub int4 NULL, -- количество в формуле выражений с def_sub
	dsm_cnt_msr_conf_agg int4 NULL, -- количество в формуле выражений с agg
	dsd_json_conf jsonb NULL -- контент в json
);
COMMENT ON TABLE public.z01_msr_conf IS '?Датасеты или виджеты: меры';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_id IS 'id меры';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_name IS 'имя меры';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_type_data IS 'тип данных меры';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_type IS 'тип меры';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_model IS '?';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_calc_type IS '?';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_calc_value IS '?';
COMMENT ON COLUMN public.z01_msr_conf.dsm_msr_calc_aggregate IS '?';
COMMENT ON COLUMN public.z01_msr_conf.dsm_cnt_msr_conf_id IS 'количество в формуле выражений с id';
COMMENT ON COLUMN public.z01_msr_conf.dsm_cnt_msr_conf_switch IS 'количество в формуле выражений с switch';
COMMENT ON COLUMN public.z01_msr_conf.dsm_cnt_msr_conf_def IS 'количество в формуле выражений с def';
COMMENT ON COLUMN public.z01_msr_conf.dsm_cnt_msr_conf_def_add IS 'количество в формуле выражений с def_add';
COMMENT ON COLUMN public.z01_msr_conf.dsm_cnt_msr_conf_def_sub IS 'количество в формуле выражений с def_sub';
COMMENT ON COLUMN public.z01_msr_conf.dsm_cnt_msr_conf_agg IS 'количество в формуле выражений с agg';
COMMENT ON COLUMN public.z01_msr_conf.dsd_json_conf IS 'контент в json';

--
