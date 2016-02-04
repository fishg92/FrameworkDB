
----------------------------------------------------------------------------
-- Select a single record from FormJoinQuickListFormNameAnnotationAnnotationValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinQuickListFormNameAnnotationAnnotationValueSelect]
(	@pkFormJoinQuickListFormNameAnnotationAnnotationValue decimal(18, 0) = NULL,
	@fkQuickListFormName decimal(18, 0) = NULL,
	@fkFormAnnotation decimal(18, 0) = NULL,
	@fkAnnotationValueSmall decimal(10, 0) = NULL,
	@fkAnnotationValueMedium decimal(10, 0) = NULL,
	@fkAnnotationValueLarge decimal(10, 0) = NULL,
	@fkAnnotationValueHuge decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinQuickListFormNameAnnotationAnnotationValue,
	fkQuickListFormName,
	fkFormAnnotation,
	fkAnnotationValueSmall,
	fkAnnotationValueMedium,
	fkAnnotationValueLarge,
	fkAnnotationValueHuge
	
FROM	FormJoinQuickListFormNameAnnotationAnnotationValue
WHERE 	(@pkFormJoinQuickListFormNameAnnotationAnnotationValue IS NULL OR pkFormJoinQuickListFormNameAnnotationAnnotationValue = @pkFormJoinQuickListFormNameAnnotationAnnotationValue)
 AND 	(@fkQuickListFormName IS NULL OR fkQuickListFormName = @fkQuickListFormName)
 AND 	(@fkFormAnnotation IS NULL OR fkFormAnnotation = @fkFormAnnotation)
 AND 	(@fkAnnotationValueSmall IS NULL OR fkAnnotationValueSmall = @fkAnnotationValueSmall)
 AND 	(@fkAnnotationValueMedium IS NULL OR fkAnnotationValueMedium = @fkAnnotationValueMedium)
 AND 	(@fkAnnotationValueLarge IS NULL OR fkAnnotationValueLarge = @fkAnnotationValueLarge)
 AND 	(@fkAnnotationValueHuge IS NULL OR fkAnnotationValueHuge = @fkAnnotationValueHuge)


