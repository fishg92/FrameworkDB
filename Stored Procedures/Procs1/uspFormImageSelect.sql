----------------------------------------------------------------------------
-- Select a single record from FormImage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormImageSelect]
(	@pkFormImage decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL,
	@Image varbinary(MAX) = NULL,
	@FileExtension varchar(10) = NULL
)
AS

SELECT	pkFormImage,
	fkFormName,
	Image,
	FileExtension
FROM	FormImage
WHERE 	(@pkFormImage IS NULL OR pkFormImage = @pkFormImage)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@FileExtension IS NULL OR FileExtension LIKE @FileExtension + '%')

