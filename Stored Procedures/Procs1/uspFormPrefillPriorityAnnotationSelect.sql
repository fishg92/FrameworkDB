----------------------------------------------------------------------------
-- Select a single record from FormPrefillPriorityAnnotation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormPrefillPriorityAnnotationSelect]
(	@pkFormPrefillPriorityAnnotation decimal(18, 0) = NULL,
	@KeywordName varchar(200) = NULL,
	@Position int = NULL
)
AS

SELECT	pkFormPrefillPriorityAnnotation,
	KeywordName,
	Position
FROM	FormPrefillPriorityAnnotation
WHERE 	(@pkFormPrefillPriorityAnnotation IS NULL OR pkFormPrefillPriorityAnnotation = @pkFormPrefillPriorityAnnotation)
 AND 	(@KeywordName IS NULL OR KeywordName LIKE @KeywordName + '%')
 AND 	(@Position IS NULL OR Position = @Position)
