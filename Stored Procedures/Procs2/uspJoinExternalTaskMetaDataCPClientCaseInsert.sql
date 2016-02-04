----------------------------------------------------------------------------
-- Insert a single record into JoinExternalTaskMetaDataCPClientCase
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinExternalTaskMetaDataCPClientCaseInsert]
(	  @fkExternalTaskMetaData decimal(18, 0)
	, @fkCPClientCase decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinExternalTaskMetaDataCPClientCase decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinExternalTaskMetaDataCPClientCase
(	  fkExternalTaskMetaData
	, fkCPClientCase
)
VALUES 
(	  @fkExternalTaskMetaData
	, @fkCPClientCase

)

SET @pkJoinExternalTaskMetaDataCPClientCase = SCOPE_IDENTITY()
