--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z11_usr_status (
	um_userid varchar(255) NULL, -- ID пользователя
	um_is_platform int4 NULL, -- Признак: 1 - активен на платформе
	um_is_viewer int4 NULL, -- Признак: 1 - активен как Viewer
	um_is_dev int4 NULL, -- Признак: 1 - активен как Designer
	um_is_datam int4 NULL -- ? Признак: 1 - активен как Dataminer
);
COMMENT ON TABLE public.z11_usr_status IS 'ОМ: объекты: пользователи: состояние УЗ (активация на платформе и роль)';
COMMENT ON COLUMN public.z11_usr_status.um_userid IS 'ID пользователя';
COMMENT ON COLUMN public.z11_usr_status.um_is_platform IS 'Признак: 1 - активен на платформе';
COMMENT ON COLUMN public.z11_usr_status.um_is_viewer IS 'Признак: 1 - активен как Viewer';
COMMENT ON COLUMN public.z11_usr_status.um_is_dev IS 'Признак: 1 - активен как Designer';
COMMENT ON COLUMN public.z11_usr_status.um_is_datam IS '? Признак: 1 - активен как Dataminer';
