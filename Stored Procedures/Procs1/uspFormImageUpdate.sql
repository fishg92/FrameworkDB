----------------------------------------------------------------------------
-- Update a single record in FormImage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormImageUpdate]
(	  @pkFormImage decimal(18, 0)
	, @fkFormName decimal(18, 0) = NULL
	, @Image varbinary(MAX) = NULL
	, @FileExtension varchar(10) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormImage
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	Image = ISNULL(@Image, Image),
	FileExtension = ISNULL(@FileExtension, FileExtension)
WHERE 	pkFormImage = @pkFormImage
