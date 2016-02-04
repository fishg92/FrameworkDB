CREATE proc [dbo].[TaskAssignmentSave]
	@pkTaskAssignment decimal
	,@fkTask decimal
	,@fkApplicationUserAssignedBy decimal
	,@fkApplicationUserAssignedTo decimal
	,@fkTaskAssignmentReassignedFrom decimal = null
	,@fkrefTaskAssignmentStatus decimal
	,@StartDate datetime = null
	,@CompleteDate datetime = null
	, @LUPUser varchar(50) 
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	,@pkTaskAssignmentReturn decimal = null output
as

if @pkTaskAssignment = -1
	begin
	exec uspTaskAssignmentInsert
		@fkTask = @fkTask
		,@fkApplicationUserAssignedBy = @fkApplicationUserAssignedBy
		,@fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo
		,@fkTaskAssignmentReassignedFrom = @fkTaskAssignmentReassignedFrom
		,@fkrefTaskAssignmentStatus = @fkrefTaskAssignmentStatus
		,@StartDate = @StartDate
		,@CompleteDate = @CompleteDate
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
		, @pkTaskAssignment = @pkTaskAssignmentReturn output
	end
else
	begin
	set @pkTaskAssignmentReturn = @pkTaskAssignment
	exec uspTaskUpdate
		@pkTaskAssignment = @pkTaskAssignment
		,@fkTask = @fkTask
		,@fkApplicationUserAssignedBy = @fkApplicationUserAssignedBy
		,@fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo
		,@fkTaskAssignmentReassignedFrom = @fkTaskAssignmentReassignedFrom
		,@fkrefTaskAssignmentStatus = @fkrefTaskAssignmentStatus
		,@StartDate = @StartDate
		,@CompleteDate = @CompleteDate
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end
