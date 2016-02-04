----------------------------------------------------------------------------
-- Insert a single record into ExternalDataSystemQuery
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspExternalDataSystemQueryInsert]
(	  @fkApplicationUser decimal(18, 0) = NULL
	, @fkExternalDataSystem decimal(18, 0) = NULL
	, @Query varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkExternalDataSystemQuery decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ExternalDataSystemQuery
(	  fkApplicationUser
	, fkExternalDataSystem
	, Query
)
VALUES 
(	  @fkApplicationUser
	, @fkExternalDataSystem
	, @Query

)

SET @pkExternalDataSystemQuery = SCOPE_IDENTITY()
