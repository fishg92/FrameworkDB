----------------------------------------------------------------------------
-- Select a single record from ExternalDataSystemJoinQueryClient
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemJoinQueryClientSelect]
(	@pkExternalDataSystemJoinQueryClient decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkExternalDataSystemQuery decimal(18, 0) = NULL
)
AS

SELECT	pkExternalDataSystemJoinQueryClient,
	fkCPClient,
	fkExternalDataSystemQuery
FROM	ExternalDataSystemJoinQueryClient
WHERE 	(@pkExternalDataSystemJoinQueryClient IS NULL OR pkExternalDataSystemJoinQueryClient = @pkExternalDataSystemJoinQueryClient)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkExternalDataSystemQuery IS NULL OR fkExternalDataSystemQuery = @fkExternalDataSystemQuery)
