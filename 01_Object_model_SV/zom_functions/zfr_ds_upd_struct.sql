--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfr_ds_upd_struct()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
	is_corr boolean;
	ses_id text default to_char(now(),'yyyyMMddhh24mmss');
	proc_name text default 'zfr_ds_upd_struct';
begin
	begin
call public.zfr_proc_log(proc_name,0,ses_id);
raise info '- - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
raise info '1. % execute', proc_name;
is_corr := false;
--!CODE OPERATION
delete from public.z01_ds_upd_struct;
insert into public.z01_ds_upd_struct
with
t_buf as (
	-- tableName + taskName + parseOpsETL + durationOpsTime
	select
		-- id
		ud.tableName
		,ud.tableId
		,ud.columnCount
		,ud.totalCount
		,ud.columnCount*ud.totalCount as ds_elems
		,ud.etlFlow
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'-','')))/length('-')+1 as cnt_ds_ops
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'select','')))/length('select') as cnt_ds_select
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'join','')))/length('join') as cnt_ds_join
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'addColumn','')))/length('addColumn') as cnt_ds_addColumn
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'fieldSetting','')))/length('fieldSetting') as cnt_ds_fieldSetting
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'fieldTransType','')))/length('fieldTransType') as cnt_ds_fieldTransType
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'filter','')))/length('filter') as cnt_ds_filter
				,(length(coalesce(ud.etlFlow,'1'))-length(replace(coalesce(ud.etlFlow,'1'),'group','')))/length('group') as cnt_ds_group
		,u.taskName as upd_taskName
		,ud.loadType as upd_loadType
		,ud.updateType as upd_updateType
		,to_timestamp(ud.startTime/1000)::timestamp as upd_startTime
		,to_timestamp(ud.endTime/1000)::timestamp as upd_endTime
		,case when ud.endTime > ud.startTime then (ud.endTime - ud.startTime)/1000 else null end as upd_totalTime_sec
		,coalesce(ud.openTime,0)/1000 as upd_openTime_sec
		,coalesce(ud.writeTime,0)/1000 as upd_writeTime_sec
		,coalesce(ud.jdbcTime,0)/1000 as upd_jdbcTime_sec
		 ,ud.stateType as upd_stateType
		,u.roleName as upd_roleName
		,u.runningResult as upd_runningResult
		,u.triggerType as upd_triggerType
	from public.fine_update_task_detail ud
	left join public.fine_update_task u on ud.planId = u.planId
	where length(ud.tableName)>0
	and to_timestamp(ud.endTime/1000)::timestamp >= current_date-7
	order by ud.tableName, ud.startTime desc
),
t_res as (
  select 
		tablename
		,tableid
		,columncount
		,totalcount
		,ds_elems
		,totalcount*cnt_ds_addcolumn as ds_elems_calc
		,case 
		when ds_elems between 0 and 100000 then 1
		when ds_elems between 100000 and 500000 then 2
		when ds_elems between 500000 and 1000000 then 3
		when ds_elems between 1000000 and 5000000 then 4
		when ds_elems > 5000000 then 5
		else 0
		end
		as cat_size_ds
		,etlflow
		,replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
			etlflow||'-'
			,'selectTable-','S>')
			,'fieldSetting-','s>')
			,'fieldTransType-','T>')
			,'filter-','#F>')
			,'join-','@J>')
			,'union-','@U>')
			,'addColumn-','%A>')
			,'group-','#G>')
			,'order-','#O>')
			,'columnToRow-','#C2R>')
			,'row2Column-','#R2C>')
			,'>','> ')
			as etlflow_short
			--S> columnToRow-s> T> %A> s> T> %A> #G> %A> @U> row2Column-s> T> s> s> 
		,cnt_ds_ops
		,cnt_ds_select
		,cnt_ds_join
		,cnt_ds_addcolumn
		,cnt_ds_fieldsetting
		,cnt_ds_fieldtranstype
		,cnt_ds_filter
		,cnt_ds_group
		,upd_taskname
		,upd_loadtype
		,upd_updatetype
		,upd_starttime
		,upd_endtime
		,upd_totaltime_sec
		,upd_opentime_sec
		,upd_writetime_sec
		,upd_jdbctime_sec
		,upd_statetype
		,upd_rolename
		,upd_runningresult
		,upd_triggertype
		,row_number() over (partition by tableid order by upd_starttime desc) as upd_rn
	from t_buf t
)
select * from t_res 
where etlflow is not null
and upd_rn = 1
order by tableid;
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
