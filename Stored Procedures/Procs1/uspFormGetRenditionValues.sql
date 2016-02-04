CREATE PROCEDURE [dbo].[uspFormGetRenditionValues]
(	
	@pkFormRendition decimal(18,0)
)
AS

SELECT av.AnnotationValue
	 , a.pkFormAnnotation
FROM FormAnnotationValue av WITH (NOLOCK)
JOIN FormAnnotation a WITH (NOLOCK) ON av.fkFormAnnotation = a.pkFormAnnotation
WHERE av.fkFormRendition = @pkFormRendition