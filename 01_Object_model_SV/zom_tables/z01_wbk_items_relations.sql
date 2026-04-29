--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_wbk_items_relations (
	item_pid text NULL, -- id родителя
	item_cid text NULL, -- id потомка
	name_p text NULL, -- имя родителя
	creator_pid text NULL, -- id создателя родительсткого элемента
	creator_p varchar(255) NULL, -- логин создателя родительсткого элемента
	created_pid timestamp NULL, -- дата создания родителя
	ftype_pid text NULL, -- тип элемента родитель
	name_c text NULL, -- имя потомка
	creator_cid text NULL, -- id создателя дочернего элемента
	creator_c varchar(255) NULL, -- логин создателя дочернего элемента
	created_cid timestamp NULL, -- дата создания потомка
	ftype_cid text NULL -- тип элемента потомок
);
COMMENT ON TABLE public.z01_wbk_items_relations IS 'ОМ: объекты: рабочая книга: связи для построения иерархии в z01_wbk_items_hrh';
COMMENT ON COLUMN public.z01_wbk_items_relations.item_pid IS 'id родителя';
COMMENT ON COLUMN public.z01_wbk_items_relations.item_cid IS 'id потомка';
COMMENT ON COLUMN public.z01_wbk_items_relations.name_p IS 'имя родителя';
COMMENT ON COLUMN public.z01_wbk_items_relations.creator_pid IS 'id создателя родительсткого элемента';
COMMENT ON COLUMN public.z01_wbk_items_relations.creator_p IS 'логин создателя родительсткого элемента';
COMMENT ON COLUMN public.z01_wbk_items_relations.created_pid IS 'дата создания родителя';
COMMENT ON COLUMN public.z01_wbk_items_relations.ftype_pid IS 'тип элемента родитель';
COMMENT ON COLUMN public.z01_wbk_items_relations.name_c IS 'имя потомка';
COMMENT ON COLUMN public.z01_wbk_items_relations.creator_cid IS 'id создателя дочернего элемента';
COMMENT ON COLUMN public.z01_wbk_items_relations.creator_c IS 'логин создателя дочернего элемента';
COMMENT ON COLUMN public.z01_wbk_items_relations.created_cid IS 'дата создания потомка';
COMMENT ON COLUMN public.z01_wbk_items_relations.ftype_cid IS 'тип элемента потомок';

--
