----------------------------------------------------------------------------
-- Insert a single record into ExternalDataSystemResult
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspExternalDataSystemResultInsert]
(	  @fkExternalDataSystemQuery decimal(18, 0) = NULL
	, @RawResult varbinary(MAX) = NULL
	, @ProcessedResult varbinary(MAX) = NULL
	, @Status int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkExternalDataSystemResult decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ExternalDataSystemResult
(	  fkExternalDataSystemQuery
	, RawResult
	, ProcessedResult
	, Status
)
VALUES 
(	  @fkExternalDataSystemQuery
	, @RawResult
	, @ProcessedResult
	, @Status

)

SET @pkExternalDataSystemResult = SCOPE_IDENTITY()
