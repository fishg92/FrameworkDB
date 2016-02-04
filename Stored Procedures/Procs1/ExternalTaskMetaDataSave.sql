
CREATE proc [dbo].[ExternalTaskMetaDataSave]
	 @fkExternalTask varchar(50)
	, @fkrefTaskPriority decimal(18, 0)
	, @fkrefTaskStatus decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @fkrefTaskOrigin decimal(18,0) = -1
	, @SourceModuleID int
	, @pkExternalTaskMetaData decimal(18,0) = null output
as
set @pkExternalTaskMetaData = null

select	@pkExternalTaskMetaData = pkExternalTaskMetaData
from	ExternalTaskMetaData
where	fkExternalTask = @fkExternalTask
	
if @pkExternalTaskMetaData is null
	begin
	exec dbo.uspExternalTaskMetaDataInsert
		@fkExternalTask = @fkExternalTask
		,@fkrefTaskPriority = @fkrefTaskPriority
		,@fkrefTaskStatus = @fkrefTaskStatus
		,@fkrefTaskOrigin = @fkrefTaskOrigin
		,@SourceModuleID = @SourceModuleID
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
		,@pkExternalTaskMetaData = @pkExternalTaskMetaData output
	end
else
	begin
	exec dbo.uspExternalTaskMetaDataUpdate
		@pkExternalTaskMetaData = @pkExternalTaskMetaData
		,@fkExternalTask = @fkExternalTask
		,@fkrefTaskPriority = @fkrefTaskPriority
		,@fkrefTaskStatus = @fkrefTaskStatus
		,@fkrefTaskOrigin = @fkrefTaskOrigin
		,@SourceModuleID = @SourceModuleID
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end
