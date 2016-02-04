----------------------------------------------------------------------------
-- Select a single record from ExternalDataSystemResult
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemResultSelect]
(	@pkExternalDataSystemResult decimal(18, 0) = NULL,
	@fkExternalDataSystemQuery decimal(18, 0) = NULL,
	@RawResult varbinary(MAX) = NULL,
	@ProcessedResult varbinary(MAX) = NULL,
	@Status int = NULL
)
AS

SELECT	pkExternalDataSystemResult,
	fkExternalDataSystemQuery,
	RawResult,
	ProcessedResult,
	Status
FROM	ExternalDataSystemResult
WHERE 	(@pkExternalDataSystemResult IS NULL OR pkExternalDataSystemResult = @pkExternalDataSystemResult)
 AND 	(@fkExternalDataSystemQuery IS NULL OR fkExternalDataSystemQuery = @fkExternalDataSystemQuery)
 AND 	(@Status IS NULL OR Status = @Status)
