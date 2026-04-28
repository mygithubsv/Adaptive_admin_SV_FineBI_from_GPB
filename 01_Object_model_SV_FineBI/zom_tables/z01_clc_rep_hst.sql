--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_clc_rep_hst (
	clc_id varchar(255) NULL, -- id публикации в "Коллекции"
	rn int8 NULL, -- номер дашборда в каталоге
	max_rn int8 NULL, -- всего дашбордов в каталоге
	templateid varchar(255) NULL, -- id шаблона
	dt_from_calc date NULL, -- дата начала действия публикации
	dt_till_calc date NULL -- дата окончания действия публикации
);
COMMENT ON TABLE public.z01_clc_rep_hst IS 'ОМ: объекты: история публикация дашбордов в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_rep_hst.clc_id IS 'id публикации в "Коллекции"';
COMMENT ON COLUMN public.z01_clc_rep_hst.rn IS 'номер дашборда в каталоге';
COMMENT ON COLUMN public.z01_clc_rep_hst.max_rn IS 'всего дашбордов в каталоге';
COMMENT ON COLUMN public.z01_clc_rep_hst.templateid IS 'id шаблона';
COMMENT ON COLUMN public.z01_clc_rep_hst.dt_from_calc IS 'дата начала действия публикации';
COMMENT ON COLUMN public.z01_clc_rep_hst.dt_till_calc IS 'дата окончания действия публикации';

--
