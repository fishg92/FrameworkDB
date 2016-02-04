
----------------------------------------------------------------------------
-- Select a single record from FormQuickListAdditionalStamp
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListAdditionalStampSelect]
(	@pkFormQuickListAdditionalStamp decimal(18, 0) = NULL,
	@fkFormQuickListFormName decimal(18, 0) = NULL,
	@Page int = NULL,
	@X int = NULL,
	@Y int = NULL,
	@Width int = NULL,
	@Height int = NULL,
	@Bitmap image = NULL,
	@fkrefAnnotationType decimal(10, 0) = NULL,
	@AdditionalData varchar(MAX) = NULL
)
AS

SELECT	pkFormQuickListAdditionalStamp
	, fkFormQuickListFormName
	,Page
	,X
	,Y
	,Width
	,Height
	,Bitmap
	,fkrefAnnotationType
	,AdditionalData

FROM	FormQuickListAdditionalStamp
WHERE 	(@pkFormQuickListAdditionalStamp IS NULL OR pkFormQuickListAdditionalStamp = @pkFormQuickListAdditionalStamp)
 AND 	(@fkFormQuickListFormName IS NULL OR fkFormQuickListFormName = @fkFormQuickListFormName)
 AND 	(@Page IS NULL OR Page = @Page)
 AND 	(@X IS NULL OR X = @X)
 AND 	(@Y IS NULL OR Y = @Y)
 AND 	(@Width IS NULL OR Width = @Width)
 AND 	(@Height IS NULL OR Height = @Height)
 AND 	(@fkrefAnnotationType IS NULL OR fkrefAnnotationType = @fkrefAnnotationType)
 AND 	(@AdditionalData IS NULL OR AdditionalData LIKE @AdditionalData + '%')



