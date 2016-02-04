create proc [dbo].[CreateNightlyTempTablePurgeJob]
as

declare @JobID binary(16)

select @JobID = job_id
from msdb.dbo.sysjobs
where name = 'Nightly Cleanup'

if @JobID is null
	begin

	exec msdb.dbo.sp_add_job
		@job_id = @JobID OUTPUT 
		, @job_name = 'Nightly Cleanup'
		, @description = 'Nightly cleanup of temporary data'
		, @delete_level= 0 --Never delete
		, @notify_level_eventlog = 3 --Always log
	
	if not exists (select * from msdb.dbo.sysjobsteps
					where job_id = @JobID
					and step_name = 'Nightly Cleanup')
		begin			
		declare @sql varchar(500)
				,@dbname varchar(100)
		set @sql = 'exec dbo.NightlyTempTablePurge'
		set @dbname = db_name()
		
		exec msdb.dbo.sp_add_jobstep 
			@job_id = @JobID
			, @step_id = 1
			, @step_name = 'Nightly Cleanup'
			, @command = @sql
			, @database_name = @dbname
			, @on_success_action = 1 -- quit with success
			, @on_fail_action = 2 -- quit with failure
		end		
		
	exec msdb.dbo.sp_add_jobserver
		@job_id = @JobID

	exec msdb.dbo.sp_add_jobschedule 
		@job_id = @JobID
		, @name = N'Nightly Cleanup'
		, @enabled = 1
		, @freq_type = 4 --daily
		, @freq_interval = 1 --every day
		, @active_start_date = 20050504
		, @active_start_time = 012345 --1:23:45 AM
		, @freq_subday_type = 1 --Once a day
		--, @freq_subday_interval = 1
		--, @freq_relative_interval = 0
		--, @freq_recurrence_factor = 0
		, @active_end_date = 99991231
		, @active_end_time = 235959
		
	exec msdb.dbo.sp_start_job 
		@job_name = 'Nightly Cleanup'

	end
