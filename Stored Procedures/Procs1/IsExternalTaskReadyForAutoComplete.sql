CREATE PROC [dbo].[IsExternalTaskReadyForAutoComplete]
	@pkTask varchar(50)
	,@fkrefTaskType decimal
	,@isReady bit = null output

As

/* We are assuming that the task is configured for autocomplete. It is up to the caller to know that already */
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

	declare @pkExternalTaskMetaData decimal
	select	@pkExternalTaskMetaData = pkExternalTaskMetaData
	from	ExternalTaskMetaData
	where	fkExternalTask = @pkTask

	if exists 
		(
			select	*
			from	JoinExternalTaskMetaDataCPClient
			join JoinrefTaskTypeForm
				on 1=1
			where 	JoinExternalTaskMetaDataCPClient.fkExternalTaskMetaData = @pkExternalTaskMetaData
			and		JoinrefTaskTypeForm.fkrefTaskType = @fkrefTaskType
			and not exists (select	*
							from	TaskFormCompletion
							where	TaskFormCompletion.fkTask = @pkTask
							and		TaskFormCompletion.fkCPClient = JoinExternalTaskMetaDataCPClient.fkCPClient
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