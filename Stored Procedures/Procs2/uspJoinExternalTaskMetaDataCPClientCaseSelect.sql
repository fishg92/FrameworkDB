----------------------------------------------------------------------------
-- Select a single record from JoinExternalTaskMetaDataCPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinExternalTaskMetaDataCPClientCaseSelect]
(	@pkJoinExternalTaskMetaDataCPClientCase decimal(18, 0) = NULL,
	@fkExternalTaskMetaData decimal(18, 0) = NULL,
	@fkCPClientCase decimal(18, 0) = NULL
)
AS

SELECT	pkJoinExternalTaskMetaDataCPClientCase,
	fkExternalTaskMetaData,
	fkCPClientCase
FROM	JoinExternalTaskMetaDataCPClientCase
WHERE 	(@pkJoinExternalTaskMetaDataCPClientCase IS NULL OR pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase)
 AND 	(@fkExternalTaskMetaData IS NULL OR fkExternalTaskMetaData = @fkExternalTaskMetaData)
 AND 	(@fkCPClientCase IS NULL OR fkCPClientCase = @fkCPClientCase)
