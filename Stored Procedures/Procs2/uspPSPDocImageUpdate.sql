----------------------------------------------------------------------------
-- Update a single record in PSPDocImage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPDocImageUpdate]
(	  @pkPSPDocImage decimal(18, 0)
	, @fkPSPDocType decimal(18, 0) = NULL
	, @FullImage varbinary(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPDocImage
SET	fkPSPDocType = ISNULL(@fkPSPDocType, fkPSPDocType),
	FullImage = ISNULL(@FullImage, FullImage)
WHERE 	pkPSPDocImage = @pkPSPDocImage
