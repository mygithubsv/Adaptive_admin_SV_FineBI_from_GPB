--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_rl_user2dep_pos_hist (
	dpd_id varchar(255) NULL,
	dpd_name varchar(255) NULL,
	dpd_path_ui text NULL,
	dpd_level int4 NULL,
	dpd_p1 text NULL,
	dpd_p2 text NULL,
	dpd_p3 text NULL,
	dpd_p4 text NULL,
	dpd_p5 text NULL,
	dpd_p6 text NULL,
	dpd_p7 text NULL,
	dpd_p8 text NULL,
	dpd_p9 text NULL,
	dpd_p10 text NULL,
	dpd_user_realname varchar(255) NULL,
	dpd_user_email varchar(255) NULL,
	dpd_user_id varchar(255) NULL,
	dpd_userid text NULL
);
COMMENT ON TABLE public.z01_rl_user2dep_pos_hist IS '-Тест историчное отнесение пользователей на роли';

--
