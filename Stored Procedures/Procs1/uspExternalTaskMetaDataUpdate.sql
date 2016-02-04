----------------------------------------------------------------------------
-- Update a single record in ExternalTaskMetaData
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalTaskMetaDataUpdate]
(	  @pkExternalTaskMetaData decimal(18, 0)
	, @fkExternalTask varchar(50) = NULL
	, @fkrefTaskPriority decimal(18, 0) = NULL
	, @fkrefTaskStatus decimal(18, 0) = NULL
	, @fkrefTaskOrigin decimal(18, 0) = NULL
	, @SourceModuleID int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ExternalTaskMetaData
SET	fkExternalTask = ISNULL(@fkExternalTask, fkExternalTask),
	fkrefTaskPriority = ISNULL(@fkrefTaskPriority, fkrefTaskPriority),
	fkrefTaskStatus = ISNULL(@fkrefTaskStatus, fkrefTaskStatus),
	fkrefTaskOrigin = ISNULL(@fkrefTaskOrigin, fkrefTaskOrigin),
	SourceModuleID = ISNULL(@SourceModuleID, SourceModuleID)
WHERE 	pkExternalTaskMetaData = @pkExternalTaskMetaData
