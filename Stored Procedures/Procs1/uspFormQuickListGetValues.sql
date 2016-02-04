CREATE PROCEDURE [dbo].[uspFormQuickListGetValues]
(
	@pkFormQuickListFormName decimal(18,0)
)
AS

SELECT    a.fkFormAnnotation
		, a.AnnotationValue
FROM FormJoinQuickListFormNameAnnotationAnnotationValue a
WHERE a.fkFormAnnotation IN  
(	SELECT fkFormAnnotation 
	FROM FormJoinQuickListFormNameAnnotationAnnotationValue
	WHERE fkQuickListFormName = @pkFormQuickListFormName
)
AND a.fkQuickListFormName = @pkFormQuickListFormName

