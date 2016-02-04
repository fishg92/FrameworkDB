----------------------------------------------------------------------------
-- Insert a single record into FormImage
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormImageInsert]
(	  @fkFormName decimal(18, 0)
	, @Image varbinary(MAX)
	, @FileExtension varchar(10)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormImage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormImage
(	  fkFormName
	, Image
	, FileExtension
)
VALUES 
(	  @fkFormName
	, @Image
	, @FileExtension

)

SET @pkFormImage = SCOPE_IDENTITY()
