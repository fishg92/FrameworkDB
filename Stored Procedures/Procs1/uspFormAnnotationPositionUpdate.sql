-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormAnnotationPosition
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationPositionUpdate]
(	  @pkFormAnnotationPosition decimal(18, 0)
	, @fkFormAnnotation decimal(18, 0) = NULL
	, @x int = NULL
	, @y int = NULL
	, @Width int = NULL
	, @Height int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormAnnotationPosition
SET	fkFormAnnotation = ISNULL(@fkFormAnnotation, fkFormAnnotation),
	x = ISNULL(@x, x),
	y = ISNULL(@y, y),
	Width = ISNULL(@Width, Width),
	Height = ISNULL(@Height, Height)
WHERE 	pkFormAnnotationPosition = @pkFormAnnotationPosition
