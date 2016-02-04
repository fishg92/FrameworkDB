----------------------------------------------------------------------------
-- Select a single record from JoinExternalTaskMetaDataCPClient
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinExternalTaskMetaDataCPClientSelect]
(	@pkJoinExternalTaskMetaDataCPClient decimal(18, 0) = NULL,
	@fkExternalTaskMetaData decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL
)
AS

SELECT	pkJoinExternalTaskMetaDataCPClient,
	fkExternalTaskMetaData,
	fkCPClient
FROM	JoinExternalTaskMetaDataCPClient
WHERE 	(@pkJoinExternalTaskMetaDataCPClient IS NULL OR pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient)
 AND 	(@fkExternalTaskMetaData IS NULL OR fkExternalTaskMetaData = @fkExternalTaskMetaData)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
