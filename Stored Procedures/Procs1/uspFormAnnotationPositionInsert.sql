-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormAnnotationPosition
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormAnnotationPositionInsert]
(	  @fkFormAnnotation decimal(18, 0)
	, @x int
	, @y int
	, @Width int
	, @Height int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormAnnotationPosition decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormAnnotationPosition
(	  fkFormAnnotation
	, x
	, y
	, Width
	, Height
)
VALUES 
(	  @fkFormAnnotation
	, @x
	, @y
	, @Width
	, @Height

)

SET @pkFormAnnotationPosition = SCOPE_IDENTITY()
