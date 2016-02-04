----------------------------------------------------------------------------
-- Update a single record in ExternalDataSystemResult
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemResultUpdate]
(	  @pkExternalDataSystemResult decimal(18, 0)
	, @fkExternalDataSystemQuery decimal(18, 0) = NULL
	, @RawResult varbinary(MAX) = NULL
	, @ProcessedResult varbinary(MAX) = NULL
	, @Status int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ExternalDataSystemResult
SET	fkExternalDataSystemQuery = ISNULL(@fkExternalDataSystemQuery, fkExternalDataSystemQuery),
	RawResult = ISNULL(@RawResult, RawResult),
	ProcessedResult = ISNULL(@ProcessedResult, ProcessedResult),
	Status = ISNULL(@Status, Status)
WHERE 	pkExternalDataSystemResult = @pkExternalDataSystemResult
