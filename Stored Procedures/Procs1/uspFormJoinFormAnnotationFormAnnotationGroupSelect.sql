
----------------------------------------------------------------------------
-- Select a single record from FormJoinFormAnnotationFormAnnotationGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormAnnotationFormAnnotationGroupSelect]
(	@pkFormJoinFormAnnotationFormAnnotationGroup decimal(18, 0) = NULL,
	@fkFormAnnotation decimal(18, 0) = NULL,
	@fkFormAnnotationGroup decimal(18, 0) = NULL,
	@fkForm decimal(18, 0) = NULL
)
AS

SELECT	pkFormJoinFormAnnotationFormAnnotationGroup,
	fkFormAnnotation,
	fkFormAnnotationGroup,
	fkForm
FROM	FormJoinFormAnnotationFormAnnotationGroup
WHERE 	(@pkFormJoinFormAnnotationFormAnnotationGroup IS NULL OR pkFormJoinFormAnnotationFormAnnotationGroup = @pkFormJoinFormAnnotationFormAnnotationGroup)
 AND 	(@fkFormAnnotation IS NULL OR fkFormAnnotation = @fkFormAnnotation)
 AND 	(@fkFormAnnotationGroup IS NULL OR fkFormAnnotationGroup = @fkFormAnnotationGroup)
 AND 	(@fkForm IS NULL OR fkForm = @fkForm)
