CREATE PROC [dbo].[IsCompassTaskReadyForAutoComplete]
	@pkTask decimal
	,@fkrefTaskType decimal
	,@isReady bit = null output

As

set @isReady = 0

if not exists (	select	*
				from	refTaskType
				where	pkrefTaskType = @fkrefTaskType
				and		AutoComplete = 1)
	begin
	set @isReady = 0
	end
else
	begin
	if exists 
		(
			select	*
			from	JoinTaskCPClient
			join JoinrefTaskTypeForm
				on 1=1
			where 	JoinTaskCPClient.fkTask = @pkTask
			and		JoinrefTaskTypeForm.fkrefTaskType = @fkrefTaskType
			and not exists (select	*
							from	TaskFormCompletion
							where	TaskFormCompletion.fkTask = convert(varchar,@pkTask)
							and		TaskFormCompletion.fkCPClient = JoinTaskCPClient.fkCPClient
							and		TaskFormCompletion.fkFormName = JoinrefTaskTypeForm.fkFormName)
		)
		begin
		set @isReady = 0
		end
	else
		begin
		set @isReady = 1
		end
	end
