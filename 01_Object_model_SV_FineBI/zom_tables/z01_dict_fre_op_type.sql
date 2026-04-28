--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_dict_fre_op_type (
	op_code int4 NULL, -- код операции
	op_type varchar(64) NULL, -- тип операции
	module_name varchar(50) NULL, -- модуль (FR / FineBI)
	op_cat varchar(50) NULL, -- категория операции
	op_parameter varchar(50) NULL, -- название параметра
	coding int4 NULL -- без описания (поле импорта пустое)
);
COMMENT ON TABLE public.z01_dict_fre_op_type IS 'ОМ: справочник: типы операций fine_record_execute (ручной импорт с сайта)';
COMMENT ON COLUMN public.z01_dict_fre_op_type.op_code IS 'код операции';
COMMENT ON COLUMN public.z01_dict_fre_op_type.op_type IS 'тип операции';
COMMENT ON COLUMN public.z01_dict_fre_op_type.module_name IS 'модуль (FR / FineBI)';
COMMENT ON COLUMN public.z01_dict_fre_op_type.op_cat IS 'категория операции';
COMMENT ON COLUMN public.z01_dict_fre_op_type.op_parameter IS 'название параметра';
COMMENT ON COLUMN public.z01_dict_fre_op_type.coding IS 'без описания (поле импорта пустое)';

--
