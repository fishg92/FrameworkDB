----------------------------------------------------------------------------
-- Select a single record from FormImagePage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormImagePageSelect]
(	@pkFormImagePage decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL,
	@PageNumber int = NULL,
	@ImageData varbinary(MAX) = NULL,
	@FileExtension varchar(50) = NULL
)
AS

SELECT	pkFormImagePage,
	fkFormName,
	PageNumber,
	ImageData,
	FileExtension
FROM	FormImagePage
WHERE 	(@pkFormImagePage IS NULL OR pkFormImagePage = @pkFormImagePage)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@PageNumber IS NULL OR PageNumber = @PageNumber)
 AND 	(@FileExtension IS NULL OR FileExtension LIKE @FileExtension + '%')
