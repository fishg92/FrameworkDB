----------------------------------------------------------------------------
-- Insert a single record into FormAnnotationSharedObject
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormAnnotationSharedObjectInsert]
(	  @ObjectName varchar(255) = NULL
	, @BinaryData varbinary(MAX) = NULL
	, @StringData text = NULL
	, @Active bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormAnnotationSharedObject decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormAnnotationSharedObject
(	  ObjectName
	, BinaryData
	, StringData
	, Active
)
VALUES 
(	  @ObjectName
	, @BinaryData
	, @StringData
	, @Active

)

SET @pkFormAnnotationSharedObject = SCOPE_IDENTITY()
