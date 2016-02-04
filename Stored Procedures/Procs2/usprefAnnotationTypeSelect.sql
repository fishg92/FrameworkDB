----------------------------------------------------------------------------
-- Select a single record from refAnnotationType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefAnnotationTypeSelect]
(	@pkRefAnnotationType decimal(18, 0) = NULL,
	@Name varchar(50) = NULL
)
AS

SELECT	pkRefAnnotationType,
	Name
FROM	refAnnotationType
WHERE 	(@pkRefAnnotationType IS NULL OR pkRefAnnotationType = @pkRefAnnotationType)
 AND 	(@Name IS NULL OR Name LIKE @Name + '%')

