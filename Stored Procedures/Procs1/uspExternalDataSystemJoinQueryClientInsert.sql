----------------------------------------------------------------------------
-- Insert a single record into ExternalDataSystemJoinQueryClient
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspExternalDataSystemJoinQueryClientInsert]
(	  @fkCPClient decimal(18, 0)
	, @fkExternalDataSystemQuery decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkExternalDataSystemJoinQueryClient decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ExternalDataSystemJoinQueryClient
(	  fkCPClient
	, fkExternalDataSystemQuery
)
VALUES 
(	  @fkCPClient
	, @fkExternalDataSystemQuery

)

SET @pkExternalDataSystemJoinQueryClient = SCOPE_IDENTITY()
