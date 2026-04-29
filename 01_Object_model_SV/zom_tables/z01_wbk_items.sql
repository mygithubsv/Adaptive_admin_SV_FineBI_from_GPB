--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wbk_items (
	wbk_id text NULL, -- ID элемента песочницы
	wbk_item_name text NULL, -- Название элемента песочницы
	wbk_item_creator varchar(255) NULL, -- Создатель элемента песочницы
	wbk_creator text NULL, -- Создатель элемента песочницы
	wbk_item_created timestamp NULL, -- Дата создания элемента песочницы
	wbk_ftype text NULL, -- Признак: 0 - Рабочая книга, 1 - каталог песочницы
	wbk_item_id text NULL, -- Название элемента песочницы
	wbk_item_type int4 NULL, -- ID типа элемента песочницы
	wbk_item_type_t text NULL -- Тип элемента песочницы
);
COMMENT ON TABLE public.z01_wbk_items IS 'ОМ: объекты: рабочая книга: элементы (датасеты, компоненты, дашборды, аналитические документы)';
COMMENT ON COLUMN public.z01_wbk_items.wbk_id IS 'ID элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_item_name IS 'Название элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_item_creator IS 'Создатель элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_creator IS 'Создатель элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_item_created IS 'Дата создания элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_ftype IS 'Признак: 0 - Рабочая книга, 1 - каталог песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_item_id IS 'Название элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_item_type IS 'ID типа элемента песочницы';
COMMENT ON COLUMN public.z01_wbk_items.wbk_item_type_t IS 'Тип элемента песочницы';

--
