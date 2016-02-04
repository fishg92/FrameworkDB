----------------------------------------------------------------------------
-- Insert a single record into ExternalTaskMetaData
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspExternalTaskMetaDataInsert]
(	  @fkExternalTask varchar(50)
	, @fkrefTaskPriority decimal(18, 0) = NULL
	, @fkrefTaskStatus decimal(18, 0) = NULL
	, @fkrefTaskOrigin decimal(18, 0) = NULL
	, @SourceModuleID int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkExternalTaskMetaData decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ExternalTaskMetaData
(	  fkExternalTask
	, fkrefTaskPriority
	, fkrefTaskStatus
	, fkrefTaskOrigin
	, SourceModuleID
)
VALUES 
(	  @fkExternalTask
	, COALESCE(@fkrefTaskPriority, (2))
	, COALESCE(@fkrefTaskStatus, (1))
	, COALESCE(@fkrefTaskOrigin, (-1))
	, @SourceModuleID

)

SET @pkExternalTaskMetaData = SCOPE_IDENTITY()
