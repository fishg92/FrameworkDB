----------------------------------------------------------------------------
-- Insert a single record into JoinExternalTaskMetaDataCPClient
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinExternalTaskMetaDataCPClientInsert]
(	  @fkExternalTaskMetaData decimal(18, 0)
	, @fkCPClient decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinExternalTaskMetaDataCPClient decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinExternalTaskMetaDataCPClient
(	  fkExternalTaskMetaData
	, fkCPClient
)
VALUES 
(	  @fkExternalTaskMetaData
	, @fkCPClient

)

SET @pkJoinExternalTaskMetaDataCPClient = SCOPE_IDENTITY()
