
CREATE proc [dbo].[GetExternalTaskMetaData]
	@fkExternalTask varchar(50)
	,@fkrefTaskType decimal
	,@fkApplicationUser decimal
	,@pkExternalTaskMetaData decimal = null output
	,@fkrefTaskStatus decimal = null output
	,@fkrefTaskPriority decimal = null output
	,@CreateDate datetime = null output
	,@UserRead bit = null output
	,@UserReadNote bit = null output
	,@fkrefTaskOrigin decimal = null output
	,@SourceModuleID int = null output
	,@StateCaseNumber varchar(255) = null output
	,@TaskClientInfo varchar(255) = null output
as
select	@pkExternalTaskMetaData = pkExternalTaskMetaData
		,@fkrefTaskStatus = fkrefTaskStatus
		,@fkrefTaskPriority = fkrefTaskPriority
		,@fkrefTaskOrigin = fkrefTaskOrigin
		,@SourceModuleID = isnull(SourceModuleID,-1)
from	ExternalTaskMetaData
where	fkExternalTask = @fkExternalTask

select @StateCaseNumber = dbo.ExternalTaskStateCaseNumber(@fkExternalTask)
select @TaskClientInfo = dbo.ExternalTaskClientInfo(@fkExternalTask)

if @fkrefTaskStatus is null
	begin
	select @fkrefTaskPriority = DefaultPriority
			,@fkrefTaskStatus = 1
	from	refTaskType
	where	pkrefTaskType = @fkrefTaskType
	
	set @fkrefTaskPriority = isnull(@fkrefTaskPriority,2)
	set @fkrefTaskStatus = 1
	
	insert ExternalTaskMetaData
		(
			fkExternalTask
			,fkrefTaskPriority
			,fkrefTaskStatus
		)
	values
		(
			@fkExternalTask
			,@fkrefTaskPriority
			,1
		)
		
	set @pkExternalTaskMetaData = scope_identity()
	end
else
	begin
	set @CreateDate = (	select	min(AuditStartDate)
						from	ExternalTaskMetaDataAudit
						where	pkExternalTaskMetaData = @pkExternalTaskMetaData)
	
	end

set @CreateDate = isnull(@CreateDate,getdate())

declare @pkJoinExternalTaskMetaDataApplicationUser decimal(18,0)

select	@UserRead = UserRead
		,@UserReadNote = UserReadNote
		,@pkJoinExternalTaskMetaDataApplicationUser = pkJoinExternalTaskMetaDataApplicationUser
from	JoinExternalTaskMetaDataApplicationUser
where	fkExternalTaskMetaData = @pkExternalTaskMetaData
and		fkApplicationUser = @fkApplicationUser

if @UserRead is null
	begin
	insert	JoinExternalTaskMetaDataApplicationUser
		(
			fkApplicationUser
			,fkExternalTaskMetaData
			,UserRead
		)
		values
		(
			@fkApplicationUser
			,@pkExternalTaskMetaData
			,0
		)
	
	set @UserRead = 0
	end
	
IF @UserReadNote IS NULL
	BEGIN
		UPDATE	JoinExternalTaskMetaDataApplicationUser
		SET		UserReadNote = 0
		WHERE	fkApplicationUser = @fkApplicationUser
		AND		fkExternalTaskMetaData = @pkExternalTaskMetaData
	
		SET @UserReadNote = 0
	END
