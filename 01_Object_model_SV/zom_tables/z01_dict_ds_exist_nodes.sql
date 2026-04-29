--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_dict_ds_exist_nodes (
	node_id varchar(36) NULL, -- ID ноды
	node_name varchar(50) NULL, -- DNS имя ноды
	node_ip varchar(12) NULL, -- IP ноды
	is_active int2 NULL -- Признак: 1 - активная
);
COMMENT ON TABLE public.z01_dict_ds_exist_nodes IS 'ОМ: объекты: датасеты: наличие кэша данных на нодах';
COMMENT ON COLUMN public.z01_dict_ds_exist_nodes.node_id IS 'ID ноды';
COMMENT ON COLUMN public.z01_dict_ds_exist_nodes.node_name IS 'DNS имя ноды';
COMMENT ON COLUMN public.z01_dict_ds_exist_nodes.node_ip IS 'IP ноды';
COMMENT ON COLUMN public.z01_dict_ds_exist_nodes.is_active IS 'Признак: 1 - активная';

--
