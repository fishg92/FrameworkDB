----------------------------------------------------------------------------
-- Update a single record in JoinExternalTaskMetaDataCPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinExternalTaskMetaDataCPClientCaseUpdate]
(	  @pkJoinExternalTaskMetaDataCPClientCase decimal(18, 0)
	, @fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinExternalTaskMetaDataCPClientCase
SET	fkExternalTaskMetaData = ISNULL(@fkExternalTaskMetaData, fkExternalTaskMetaData),
	fkCPClientCase = ISNULL(@fkCPClientCase, fkCPClientCase)
WHERE 	pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase
