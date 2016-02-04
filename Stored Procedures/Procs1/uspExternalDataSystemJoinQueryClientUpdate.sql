----------------------------------------------------------------------------
-- Update a single record in ExternalDataSystemJoinQueryClient
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemJoinQueryClientUpdate]
(	  @pkExternalDataSystemJoinQueryClient decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkExternalDataSystemQuery decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ExternalDataSystemJoinQueryClient
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkExternalDataSystemQuery = ISNULL(@fkExternalDataSystemQuery, fkExternalDataSystemQuery)
WHERE 	pkExternalDataSystemJoinQueryClient = @pkExternalDataSystemJoinQueryClient
