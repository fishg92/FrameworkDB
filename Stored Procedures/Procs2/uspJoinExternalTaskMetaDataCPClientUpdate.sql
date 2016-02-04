----------------------------------------------------------------------------
-- Update a single record in JoinExternalTaskMetaDataCPClient
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinExternalTaskMetaDataCPClientUpdate]
(	  @pkJoinExternalTaskMetaDataCPClient decimal(18, 0)
	, @fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinExternalTaskMetaDataCPClient
SET	fkExternalTaskMetaData = ISNULL(@fkExternalTaskMetaData, fkExternalTaskMetaData),
	fkCPClient = ISNULL(@fkCPClient, fkCPClient)
WHERE 	pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient
