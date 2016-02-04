----------------------------------------------------------------------------
-- Update a single record in FormAnnotationSharedObject
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationSharedObjectUpdate]
(	  @pkFormAnnotationSharedObject decimal(18, 0)
	, @ObjectName varchar(255) = NULL
	, @BinaryData varbinary(MAX) = NULL
	, @StringData text = NULL
	, @Active bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormAnnotationSharedObject
SET	ObjectName = ISNULL(@ObjectName, ObjectName),
	BinaryData = ISNULL(@BinaryData, BinaryData),
	StringData = ISNULL(@StringData, StringData),
	Active = ISNULL(@Active, Active)
WHERE 	pkFormAnnotationSharedObject = @pkFormAnnotationSharedObject
