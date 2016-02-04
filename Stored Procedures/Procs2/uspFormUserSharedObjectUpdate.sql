----------------------------------------------------------------------------
-- Update a single record in FormUserSharedObject
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormUserSharedObjectUpdate]
(	  @pkFormUserSharedObject decimal(18, 0)
	, @fkFrameworkUserID decimal(18, 0) = NULL
	, @fkFormAnnotationSharedObject decimal(18, 0) = NULL
	, @Value text = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormUserSharedObject
SET	fkFrameworkUserID = ISNULL(@fkFrameworkUserID, fkFrameworkUserID),
	fkFormAnnotationSharedObject = ISNULL(@fkFormAnnotationSharedObject, fkFormAnnotationSharedObject),
	Value = ISNULL(@Value, Value)
WHERE 	pkFormUserSharedObject = @pkFormUserSharedObject
