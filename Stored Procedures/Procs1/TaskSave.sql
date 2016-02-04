CREATE proc [dbo].[TaskSave]
	@pkTask decimal
	,@fkrefTaskType decimal
	,@DueDate datetime=null
	,@Note varchar(2000)
	,@fkrefTaskStatus decimal
	,@Priority tinyint
	,@StartDate datetime = null
	,@CompleteDate datetime = null
	,@GroupTask bit
	, @LUPUser varchar(50) 
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	,@pkTaskReturn decimal = null output
as

if @pkTask = -1
	begin
	exec uspTaskInsert
		@fkrefTaskType = @fkrefTaskType
		, @DueDate = @DueDate
		, @Note = @Note
		, @fkrefTaskStatus = @fkrefTaskStatus
		, @Priority = @Priority
		, @StartDate = @StartDate
		, @CompleteDate = @CompleteDate
		, @GroupTask = @GroupTask
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
		, @pkTask = @pkTaskReturn output
	end
else
	begin
	set @pkTaskReturn = @pkTask
	exec uspTaskUpdate
		@pkTask = @pkTask
		, @fkrefTaskType = @fkrefTaskType
		, @DueDate = @DueDate
		, @Note = @Note
		, @fkrefTaskStatus = @fkrefTaskStatus
		, @Priority = @Priority
		, @StartDate = @StartDate
		, @CompleteDate = @CompleteDate
		, @GroupTask = @GroupTask
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end
