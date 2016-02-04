----------------------------------------------------------------------------
-- Insert a single record into FormQuickListAdditionalStamp
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListAdditionalStampInsert]
(	  @fkFormQuickListFormName decimal(18, 0)
	, @Page int
	, @X int
	, @Y int
	, @Width int
	, @Height int
	, @Bitmap image = NULL
	, @fkrefAnnotationType decimal(18,0)
	, @AdditionalData varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LupMachine varchar(15)
	, @pkFormQuickListAdditionalStamp decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormQuickListAdditionalStamp
(	  fkFormQuickListFormName
	, Page
	, X
	, Y
	, Width
	, Height
	, Bitmap
	, fkrefAnnotationType
	, AdditionalData
)
VALUES 
(	  @fkFormQuickListFormName
	, @Page
	, @X
	, @Y
	, @Width
	, @Height
	, @Bitmap
	, @fkrefAnnotationType
	, @AdditionalData

)

SET @pkFormQuickListAdditionalStamp = SCOPE_IDENTITY()