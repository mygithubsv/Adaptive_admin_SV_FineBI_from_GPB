--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_zom_hist (
	add_date timestamptz NULL,
	group_desc varchar NULL,
	group_table text COLLATE "C" NULL,
	table_cat text COLLATE "C" NULL,
	function_name information_schema."sql_identifier" COLLATE "C" NULL,
	table_schema information_schema."sql_identifier" COLLATE "C" NULL,
	table_name information_schema."sql_identifier" COLLATE "C" NULL,
	table_desc text NULL,
	pos_num information_schema."cardinal_number" NULL,
	column_origin text NULL,
	column_name information_schema."sql_identifier" COLLATE "C" NULL,
	column_desc text COLLATE "C" NULL,
	data_type_group text NULL,
	data_type varchar COLLATE "C" NULL,
	has_zfr int4 NULL,
	has_ds_in_sv int4 NULL,
	has_table_desc int4 NULL,
	has_column_desc int4 NULL,
	col_state_dev text COLLATE "C" NULL,
	col_state_dev_t text NULL,
	table_state_dev text NULL,
	table_state_dev_t text NULL
);
COMMENT ON TABLE public.z01_zom_hist IS '-Тест истории изменений автописаний';

--
