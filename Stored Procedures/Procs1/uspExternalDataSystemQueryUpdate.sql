----------------------------------------------------------------------------
-- Update a single record in ExternalDataSystemQuery
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemQueryUpdate]
(	  @pkExternalDataSystemQuery decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkExternalDataSystem decimal(18, 0) = NULL
	, @Query varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ExternalDataSystemQuery
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkExternalDataSystem = ISNULL(@fkExternalDataSystem, fkExternalDataSystem),
	Query = ISNULL(@Query, Query)
WHERE 	pkExternalDataSystemQuery = @pkExternalDataSystemQuery
