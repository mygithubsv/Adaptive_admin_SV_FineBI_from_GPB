--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_upd_sch_ds_cron_parse()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_upd_sch_ds_cron_parse';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_upd_sch_ds_cron_parse;
raise info '1.1 парсинг списка часов cron в сетку часов';
insert into public.z01_upd_sch_ds_cron_parse --create table public.z01_upd_sch_ds_cron_parse as 
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) like '%,%'
    --
    union all 
    --
    select timelist_cron_uni as timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) like '%,%'
)
select distinct
    timelist_cron_uni
    ,cron as cron_hour
    , case when strpos(concat(concat(',',cron),','),',1,')>0 then 1 else null end as h_0
    , case when strpos(concat(concat(',',cron),','),',1,')>0 then 1 else null end as h_1
    , case when strpos(concat(concat(',',cron),','),',2,')>0 then 1 else null end as h_2
    , case when strpos(concat(concat(',',cron),','),',3,')>0 then 1 else null end as h_3
    , case when strpos(concat(concat(',',cron),','),',4,')>0 then 1 else null end as h_4
    , case when strpos(concat(concat(',',cron),','),',5,')>0 then 1 else null end as h_5
    , case when strpos(concat(concat(',',cron),','),',6,')>0 then 1 else null end as h_6
    , case when strpos(concat(concat(',',cron),','),',7,')>0 then 1 else null end as h_7
    , case when strpos(concat(concat(',',cron),','),',8,')>0 then 1 else null end as h_8
    , case when strpos(concat(concat(',',cron),','),',9,')>0 then 1 else null end as h_9
    , case when strpos(concat(concat(',',cron),','),',10,')>0 then 1 else null end as h_10
    , case when strpos(concat(concat(',',cron),','),',11,')>0 then 1 else null end as h_11
    , case when strpos(concat(concat(',',cron),','),',12,')>0 then 1 else null end as h_12
    , case when strpos(concat(concat(',',cron),','),',13,')>0 then 1 else null end as h_13
    , case when strpos(concat(concat(',',cron),','),',14,')>0 then 1 else null end as h_14
    , case when strpos(concat(concat(',',cron),','),',15,')>0 then 1 else null end as h_15
    , case when strpos(concat(concat(',',cron),','),',16,')>0 then 1 else null end as h_16
    , case when strpos(concat(concat(',',cron),','),',17,')>0 then 1 else null end as h_17
    , case when strpos(concat(concat(',',cron),','),',18,')>0 then 1 else null end as h_18
    , case when strpos(concat(concat(',',cron),','),',19,')>0 then 1 else null end as h_19
    , case when strpos(concat(concat(',',cron),','),',20,')>0 then 1 else null end as h_20
    , case when strpos(concat(concat(',',cron),','),',21,')>0 then 1 else null end as h_21
    , case when strpos(concat(concat(',',cron),','),',22,')>0 then 1 else null end as h_22
    , case when strpos(concat(concat(',',cron),','),',23,')>0 then 1 else null end as h_23
from t_buf
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse);
--
raise info '1.2. парсинг периода в часах cron в сетку часов';
insert into public.z01_upd_sch_ds_cron_parse
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) like '%-%'
    --
    union all 
    --
    select timelist_cron_uni as timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) like '%-%'
)
select
    timelist_cron_uni
    ,cron as cron_hour
    , case when 0 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_0
    , case when 1 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_1
    , case when 2 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_2
    , case when 3 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_3
    , case when 4 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_4
    , case when 5 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_5
    , case when 6 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_6
    , case when 7 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_7
    , case when 8 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_8
    , case when 9 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_9
    , case when 10 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_10
    , case when 11 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_11
    , case when 12 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_12
    , case when 13 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_13
    , case when 14 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_14
    , case when 15 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_15
    , case when 16 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_16
    , case when 17 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_17
    , case when 18 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_18
    , case when 19 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_19
    , case when 20 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_20
    , case when 21 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_21
    , case when 22 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_22
    , case when 23 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_23
from t_buf
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse);
--
raise info '1.3. парсинг периода cron в произвольных интервалах в сетку часов';
insert into public.z01_upd_sch_ds_cron_parse 
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) like '%/%'
    --
    union all 
    --
    select timelist_cron_uni as timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) like '%/%'
    
),
t_set as (
    select timelist_cron_uni, cron, split_part(cron, '/', 1) as start_hr, split_part(cron, '/', -1) as intrvl_hr
    from t_buf -- ) select * from t_set
),
t_hour_list as (
    select 1 as tmpl_hr union select 2 as tmpl_hr union select 3 as tmpl_hr union select 4 as tmpl_hr union
    select 5 as tmpl_hr union select 6 as tmpl_hr union select 7 as tmpl_hr union select 8 as tmpl_hr union
    select 9 as tmpl_hr union select 10 as tmpl_hr union select 11 as tmpl_hr union select 12 as tmpl_hr union
    select 13 as tmpl_hr union select 14 as tmpl_hr union select 15 as tmpl_hr union select 16 as tmpl_hr union
    select 17 as tmpl_hr union select 18 as tmpl_hr union select 19 as tmpl_hr union select 20 as tmpl_hr union
    select 21 as tmpl_hr union select 22 as tmpl_hr union select 23 as tmpl_hr union select 24 as tmpl_hr
),
t_row as (
select
    timelist_cron_uni,
    cron,
    start_hr,intrvl_hr,tmpl_hr
    ,case
        when public.try_cast_int(intrvl_hr) = 0 then -1
        when public.try_cast_int(intrvl_hr) in (1,5,7,9,10,11) or public.try_cast_int(intrvl_hr) between 13 and 23 then 1
        when mod(public.try_cast_int(start_hr)+public.try_cast_int(intrvl_hr),public.try_cast_int(intrvl_hr)) = mod(tmpl_hr::int,public.try_cast_int(intrvl_hr)) then 1
        else 0 end
        as is_planned
from t_set t
join t_hour_list h on 1=1
)
select 
  timelist_cron_uni
  ,cron
  ,max(case when tmpl_hr = 0 and is_planned = 1 then 1 else null end) as h_0
  ,max(case when tmpl_hr = 1 and is_planned = 1 then 1 else null end) as h_1
  ,max(case when tmpl_hr = 2 and is_planned = 1 then 1 else null end) as h_2
  ,max(case when tmpl_hr = 3 and is_planned = 1 then 1 else null end) as h_3
  ,max(case when tmpl_hr = 4 and is_planned = 1 then 1 else null end) as h_4
  ,max(case when tmpl_hr = 5 and is_planned = 1 then 1 else null end) as h_5
  ,max(case when tmpl_hr = 6 and is_planned = 1 then 1 else null end) as h_6
  ,max(case when tmpl_hr = 7 and is_planned = 1 then 1 else null end) as h_7
  ,max(case when tmpl_hr = 8 and is_planned = 1 then 1 else null end) as h_8
  ,max(case when tmpl_hr = 9 and is_planned = 1 then 1 else null end) as h_9
  ,max(case when tmpl_hr = 10 and is_planned = 1 then 1 else null end) as h_10
  ,max(case when tmpl_hr = 11 and is_planned = 1 then 1 else null end) as h_11
  ,max(case when tmpl_hr = 12 and is_planned = 1 then 1 else null end) as h_12
  ,max(case when tmpl_hr = 13 and is_planned = 1 then 1 else null end) as h_13
  ,max(case when tmpl_hr = 14 and is_planned = 1 then 1 else null end) as h_14
  ,max(case when tmpl_hr = 15 and is_planned = 1 then 1 else null end) as h_15
  ,max(case when tmpl_hr = 16 and is_planned = 1 then 1 else null end) as h_16
  ,max(case when tmpl_hr = 17 and is_planned = 1 then 1 else null end) as h_17
  ,max(case when tmpl_hr = 18 and is_planned = 1 then 1 else null end) as h_18
  ,max(case when tmpl_hr = 19 and is_planned = 1 then 1 else null end) as h_19
  ,max(case when tmpl_hr = 20 and is_planned = 1 then 1 else null end) as h_20
  ,max(case when tmpl_hr = 21 and is_planned = 1 then 1 else null end) as h_21
  ,max(case when tmpl_hr = 22 and is_planned = 1 then 1 else null end) as h_22
  ,max(case when tmpl_hr = 23 and is_planned = 1 then 1 else null end) as h_23
from t_row
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse)
group by 
  timelist_cron_uni
  ,cron;
--
raise info '2 Отнесение часа на столбец';
raise info '2.1 парсинг списка часов cron в сетку часов';
insert into public.z01_upd_sch_ds_cron_parse --create table public.z01_upd_sch_ds_cron_parse as
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) like '%,%'
    --
    union all 
    --
    select timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) like '%,%'
)
select distinct
    timelist_cron_uni
    ,cron as cron_hour
    , case when strpos(concat(concat(',',cron),','),',1,')>0 then 1 else null end as h_0
    , case when strpos(concat(concat(',',cron),','),',1,')>0 then 1 else null end as h_1
    , case when strpos(concat(concat(',',cron),','),',2,')>0 then 1 else null end as h_2
    , case when strpos(concat(concat(',',cron),','),',3,')>0 then 1 else null end as h_3
    , case when strpos(concat(concat(',',cron),','),',4,')>0 then 1 else null end as h_4
    , case when strpos(concat(concat(',',cron),','),',5,')>0 then 1 else null end as h_5
    , case when strpos(concat(concat(',',cron),','),',6,')>0 then 1 else null end as h_6
    , case when strpos(concat(concat(',',cron),','),',7,')>0 then 1 else null end as h_7
    , case when strpos(concat(concat(',',cron),','),',8,')>0 then 1 else null end as h_8
    , case when strpos(concat(concat(',',cron),','),',9,')>0 then 1 else null end as h_9
    , case when strpos(concat(concat(',',cron),','),',10,')>0 then 1 else null end as h_10
    , case when strpos(concat(concat(',',cron),','),',11,')>0 then 1 else null end as h_11
    , case when strpos(concat(concat(',',cron),','),',12,')>0 then 1 else null end as h_12
    , case when strpos(concat(concat(',',cron),','),',13,')>0 then 1 else null end as h_13
    , case when strpos(concat(concat(',',cron),','),',14,')>0 then 1 else null end as h_14
    , case when strpos(concat(concat(',',cron),','),',15,')>0 then 1 else null end as h_15
    , case when strpos(concat(concat(',',cron),','),',16,')>0 then 1 else null end as h_16
    , case when strpos(concat(concat(',',cron),','),',17,')>0 then 1 else null end as h_17
    , case when strpos(concat(concat(',',cron),','),',18,')>0 then 1 else null end as h_18
    , case when strpos(concat(concat(',',cron),','),',19,')>0 then 1 else null end as h_19
    , case when strpos(concat(concat(',',cron),','),',20,')>0 then 1 else null end as h_20
    , case when strpos(concat(concat(',',cron),','),',21,')>0 then 1 else null end as h_21
    , case when strpos(concat(concat(',',cron),','),',22,')>0 then 1 else null end as h_22
    , case when strpos(concat(concat(',',cron),','),',23,')>0 then 1 else null end as h_23
from t_buf
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse);
--
raise info '2.2 парсинг периода в часах cron в сетку часов';
insert into public.z01_upd_sch_ds_cron_parse --create table public.z01_upd_sch_ds_cron_parse as
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) like '%-%'
    --
    union all 
    --
    select timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) like '%-%'
)
select
    timelist_cron_uni
    ,cron as cron_hour
    , case when 0 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_0
    , case when 1 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_1
    , case when 2 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_2
    , case when 3 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_3
    , case when 4 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_4
    , case when 5 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_5
    , case when 6 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_6
    , case when 7 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_7
    , case when 8 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_8
    , case when 9 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_9
    , case when 10 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_10
    , case when 11 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_11
    , case when 12 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_12
    , case when 13 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_13
    , case when 14 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_14
    , case when 15 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_15
    , case when 16 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_16
    , case when 17 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_17
    , case when 18 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_18
    , case when 19 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_19
    , case when 20 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_20
    , case when 21 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_21
    , case when 22 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_22
    , case when 23 between public.try_cast_int(split_part(cron, '-', 1),0) and public.try_cast_int(split_part(cron, '-', -1),0) then 1 else null end as h_23
from t_buf
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse);
--
raise info '2.3. парсинг периода cron в произвольных интервалах в сетку часов';
insert into public.z01_upd_sch_ds_cron_parse
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) like '%/%'
    --
    union all 
    --
    select timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) like '%/%'
),
t_set as (
    select timelist_cron_uni, cron, split_part(cron, '/', 1) as start_hr, split_part(cron, '/', -1) as intrvl_hr
    from t_buf -- ) select * from t_set
),
t_hour_list as (
    select 1 as tmpl_hr union select 2 as tmpl_hr union select 3 as tmpl_hr union select 4 as tmpl_hr union
    select 5 as tmpl_hr union select 6 as tmpl_hr union select 7 as tmpl_hr union select 8 as tmpl_hr union
    select 9 as tmpl_hr union select 10 as tmpl_hr union select 11 as tmpl_hr union select 12 as tmpl_hr union
    select 13 as tmpl_hr union select 14 as tmpl_hr union select 15 as tmpl_hr union select 16 as tmpl_hr union
    select 17 as tmpl_hr union select 18 as tmpl_hr union select 19 as tmpl_hr union select 20 as tmpl_hr union
    select 21 as tmpl_hr union select 22 as tmpl_hr union select 23 as tmpl_hr union select 24 as tmpl_hr
),
t_row as (
select
    timelist_cron_uni,
    cron,
    start_hr,intrvl_hr,tmpl_hr
    ,case
        when public.try_cast_int(intrvl_hr) = 0 then -1
        when public.try_cast_int(intrvl_hr) in (1,5,7,9,10,11) or public.try_cast_int(intrvl_hr) between 13 and 23 then 1
        when mod(public.try_cast_int(start_hr)+public.try_cast_int(intrvl_hr),public.try_cast_int(intrvl_hr)) = mod(tmpl_hr::int,public.try_cast_int(intrvl_hr)) then 1
        else 0 end
        as is_planned
from t_set t
join t_hour_list h on 1=1
)
select 
  timelist_cron_uni
  ,cron
  ,max(case when tmpl_hr = 0 and is_planned = 1 then 1 else null end) as h_0
  ,max(case when tmpl_hr = 1 and is_planned = 1 then 1 else null end) as h_1
  ,max(case when tmpl_hr = 2 and is_planned = 1 then 1 else null end) as h_2
  ,max(case when tmpl_hr = 3 and is_planned = 1 then 1 else null end) as h_3
  ,max(case when tmpl_hr = 4 and is_planned = 1 then 1 else null end) as h_4
  ,max(case when tmpl_hr = 5 and is_planned = 1 then 1 else null end) as h_5
  ,max(case when tmpl_hr = 6 and is_planned = 1 then 1 else null end) as h_6
  ,max(case when tmpl_hr = 7 and is_planned = 1 then 1 else null end) as h_7
  ,max(case when tmpl_hr = 8 and is_planned = 1 then 1 else null end) as h_8
  ,max(case when tmpl_hr = 9 and is_planned = 1 then 1 else null end) as h_9
  ,max(case when tmpl_hr = 10 and is_planned = 1 then 1 else null end) as h_10
  ,max(case when tmpl_hr = 11 and is_planned = 1 then 1 else null end) as h_11
  ,max(case when tmpl_hr = 12 and is_planned = 1 then 1 else null end) as h_12
  ,max(case when tmpl_hr = 13 and is_planned = 1 then 1 else null end) as h_13
  ,max(case when tmpl_hr = 14 and is_planned = 1 then 1 else null end) as h_14
  ,max(case when tmpl_hr = 15 and is_planned = 1 then 1 else null end) as h_15
  ,max(case when tmpl_hr = 16 and is_planned = 1 then 1 else null end) as h_16
  ,max(case when tmpl_hr = 17 and is_planned = 1 then 1 else null end) as h_17
  ,max(case when tmpl_hr = 18 and is_planned = 1 then 1 else null end) as h_18
  ,max(case when tmpl_hr = 19 and is_planned = 1 then 1 else null end) as h_19
  ,max(case when tmpl_hr = 20 and is_planned = 1 then 1 else null end) as h_20
  ,max(case when tmpl_hr = 21 and is_planned = 1 then 1 else null end) as h_21
  ,max(case when tmpl_hr = 22 and is_planned = 1 then 1 else null end) as h_22
  ,max(case when tmpl_hr = 23 and is_planned = 1 then 1 else null end) as h_23
from t_row
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse)
group by 
  timelist_cron_uni
  ,cron;
--
raise info '2.4. парсинг периода часа в cron выражении';
insert into public.z01_upd_sch_ds_cron_parse
with
t_table as (
  select * from public.z01_upd_sch_table
),
t_buf as (
    select dir_timelist_cron_uni as timelist_cron_uni, split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where dir_timelist_cron_uni is not null
    and split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) not like '%,%'
    and split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) not like '%-%'
    and split_part(split_part(dir_timelist_cron_uni, ' ', 3), ' ', -1) not like '%/%'
    --
    union all
    --
    select timelist_cron_uni as timelist_cron_uni, split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) as cron
    from t_table
    where timelist_cron_uni is not null
    and split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) not like '%,%'
    and split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) not like '%-%'
    and split_part(split_part(timelist_cron_uni, ' ', 3), ' ', -1) not like '%/%'
)
select distinct
    timelist_cron_uni
    ,cron as cron_hour
    , case when public.try_cast_int(cron) = 0 then 1 else null end as h_0
    , case when public.try_cast_int(cron) = 1 then 1 else null end as h_1
    , case when public.try_cast_int(cron) = 2 then 1 else null end as h_2
    , case when public.try_cast_int(cron) = 3 then 1 else null end as h_3
    , case when public.try_cast_int(cron) = 4 then 1 else null end as h_4
    , case when public.try_cast_int(cron) = 5 then 1 else null end as h_5
    , case when public.try_cast_int(cron) = 6 then 1 else null end as h_6
    , case when public.try_cast_int(cron) = 7 then 1 else null end as h_7
    , case when public.try_cast_int(cron) = 8 then 1 else null end as h_8
    , case when public.try_cast_int(cron) = 9 then 1 else null end as h_9
    , case when public.try_cast_int(cron) = 10 then 1 else null end as h_10
    , case when public.try_cast_int(cron) = 11 then 1 else null end as h_11
    , case when public.try_cast_int(cron) = 12 then 1 else null end as h_12
    , case when public.try_cast_int(cron) = 13 then 1 else null end as h_13
    , case when public.try_cast_int(cron) = 14 then 1 else null end as h_14
    , case when public.try_cast_int(cron) = 15 then 1 else null end as h_15
    , case when public.try_cast_int(cron) = 16 then 1 else null end as h_16
    , case when public.try_cast_int(cron) = 17 then 1 else null end as h_17
    , case when public.try_cast_int(cron) = 18 then 1 else null end as h_18
    , case when public.try_cast_int(cron) = 19 then 1 else null end as h_19
    , case when public.try_cast_int(cron) = 20 then 1 else null end as h_20
    , case when public.try_cast_int(cron) = 21 then 1 else null end as h_21
    , case when public.try_cast_int(cron) = 22 then 1 else null end as h_22
    , case when public.try_cast_int(cron) = 23 then 1 else null end as h_23
from t_buf
where timelist_cron_uni not in (select timelist_cron_uni from public.z01_upd_sch_ds_cron_parse);
--#CODE OPERATION
is_corr = true;
--
raise info '2. % finish with state: %', proc_name, is_corr;
call public.zfr_proc_log(proc_name,1,ses_id);
return is_corr;
	exception
			when others then
			call public.zfr_proc_log(proc_name,0,ses_id,'code:'||sqlstate||'. '||left(sqlerrm,100));
			raise info '!!! ERROR: %', sqlerrm;
			return false;
	end;
end;
$function$
;
--
