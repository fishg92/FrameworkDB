

/*
exec [uspIsTaskReadyForAutoComplete] 9
*/
CREATE PROC [dbo].[uspIsTaskReadyForAutoComplete]
(
@TaskID decimal
)
As

/* We are assuming that the task is configured for autocomplete. It is up to the caller to know that already */
declare @ReturnValue bit
set @ReturnValue = 0

if exists
(
select * from 
	(
	select jtc.pkJoinTaskCpClientFormName,tt.AutoComplete from task t
	left join JoinrefTaskTypeForm jf
		on t.fkrefTaskType = jf.fkrefTaskType
	left Join JoinTaskCPClient jc 
		on t.pkTask = jc.fkTask
	left  join JoinTaskCPClientFormName jtc
		on jtc.fkJoinTaskCPClient = jc.pkJoinTaskCpClient
		and jtc.fkFormName = jf.fkFormName
    left join refTaskType tt
		on tt.pkrefTaskType = jf.fkrefTaskType
		and tt.AutoComplete = 1
	where t.pkTask = @TaskID 
	) a
where a.pkJoinTaskCpClientFormName is null or a.AutoComplete is null
)
BEGIN
	set @ReturnValue = 0
END ELSE BEGIN
	if exists (select 1 from task where pkTask = @TaskID) BEGIN
		set @ReturnValue = 1
	END
END

select @ReturnValue



