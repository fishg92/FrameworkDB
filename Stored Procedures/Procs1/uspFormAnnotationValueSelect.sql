----------------------------------------------------------------------------
-- Select a single record from FormAnnotationValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationValueSelect]
(	@pkFormAnnotationValue decimal(10, 0) = NULL,
	@fkFormRendition decimal(10, 0) = NULL,
	@fkFormAnnotation decimal(10, 0) = NULL,
	@fkFormAnnotationValueSmall decimal(10, 0) = NULL,
	@fkFormAnnotationValueMedium decimal(10, 0) = NULL,
	@fkFormAnnotationValueLarge decimal(10, 0) = NULL,
	@fkFormAnnotationValueHuge decimal(10, 0) = NULL
)
AS

SELECT	pkFormAnnotationValue,
	fkFormRendition,
	fkFormAnnotation,
	fkFormAnnotationValueSmall,
	fkFormAnnotationValueMedium,
	fkFormAnnotationValueLarge,
	fkFormAnnotationValueHuge
FROM	FormAnnotationValue
WHERE 	(@pkFormAnnotationValue IS NULL OR pkFormAnnotationValue = @pkFormAnnotationValue)
 AND 	(@fkFormRendition IS NULL OR fkFormRendition = @fkFormRendition)
 AND 	(@fkFormAnnotation IS NULL OR fkFormAnnotation = @fkFormAnnotation)
 AND 	(@fkFormAnnotationValueSmall IS NULL OR fkFormAnnotationValueSmall = @fkFormAnnotationValueSmall)
 AND 	(@fkFormAnnotationValueMedium IS NULL OR fkFormAnnotationValueMedium = @fkFormAnnotationValueMedium)
 AND 	(@fkFormAnnotationValueLarge IS NULL OR fkFormAnnotationValueLarge = @fkFormAnnotationValueLarge)
 AND 	(@fkFormAnnotationValueHuge IS NULL OR fkFormAnnotationValueHuge = @fkFormAnnotationValueHuge)



