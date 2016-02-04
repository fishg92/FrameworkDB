----------------------------------------------------------------------------
-- Select a single record from FormAnnotationPosition
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationPositionSelect]
(	@pkFormAnnotationPosition decimal(18, 0) = NULL,
	@fkFormAnnotation decimal(18, 0) = NULL,
	@x int = NULL,
	@y int = NULL,
	@Width int = NULL,
	@Height int = NULL
)
AS

SELECT	pkFormAnnotationPosition,
	fkFormAnnotation,
	x,
	y,
	Width,
	Height
FROM	FormAnnotationPosition
WHERE 	(@pkFormAnnotationPosition IS NULL OR pkFormAnnotationPosition = @pkFormAnnotationPosition)
 AND 	(@fkFormAnnotation IS NULL OR fkFormAnnotation = @fkFormAnnotation)
 AND 	(@x IS NULL OR x = @x)
 AND 	(@y IS NULL OR y = @y)
 AND 	(@Width IS NULL OR Width = @Width)
 AND 	(@Height IS NULL OR Height = @Height)


