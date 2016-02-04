----------------------------------------------------------------------------
-- Insert a single record into FormUserSharedObject
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormUserSharedObjectInsert]
(	  @fkFrameworkUserID decimal(18, 0)
	, @fkFormAnnotationSharedObject decimal(18, 0)
	, @Value text
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormUserSharedObject decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormUserSharedObject
(	  fkFrameworkUserID
	, fkFormAnnotationSharedObject
	, Value
)
VALUES 
(	  @fkFrameworkUserID
	, @fkFormAnnotationSharedObject
	, @Value

)

SET @pkFormUserSharedObject = SCOPE_IDENTITY()
