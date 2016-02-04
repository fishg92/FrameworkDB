----------------------------------------------------------------------------
-- Insert a single record into ExternalDataSystem
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspExternalDataSystemInsert]
(	  @Name varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkExternalDataSystem decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ExternalDataSystem
(	  Name
)
VALUES 
(	  @Name

)

SET @pkExternalDataSystem = SCOPE_IDENTITY()
