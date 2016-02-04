
----------------------------------------------------------------------------
-- Update a single record in FormQuickListAdditionalStamp
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListAdditionalStampUpdate]
(	  @pkFormQuickListAdditionalStamp decimal(18, 0)
	, @fkFormQuickListFormName decimal(18, 0) = NULL
	, @Page int = NULL
	, @X int = NULL
	, @Y int = NULL
	, @Width int = NULL
	, @Height int = NULL
	, @Bitmap image = NULL
	, @fkrefAnnotationType decimal(10, 0) = NULL
	, @AdditionalData varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LupMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormQuickListAdditionalStamp
SET	fkFormQuickListFormName = ISNULL(@fkFormQuickListFormName, fkFormQuickListFormName),
	Page = ISNULL(@Page, Page),
	X = ISNULL(@X, X),
	Y = ISNULL(@Y, Y),
	Width = ISNULL(@Width, Width),
	Height = ISNULL(@Height, Height),
	Bitmap = ISNULL(@Bitmap, Bitmap),
	fkrefAnnotationType = ISNULL(@fkrefAnnotationType, fkrefAnnotationType),
	AdditionalData = ISNULL(@AdditionalData, AdditionalData)
WHERE 	pkFormQuickListAdditionalStamp = @pkFormQuickListAdditionalStamp