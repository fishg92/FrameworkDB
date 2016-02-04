


/****** Object:  Stored Procedure dbo.GetAnnotationValueForRendition    Script Date: 8/21/2006 8:02:14 AM ******/


CREATE Procedure [dbo].[GetAnnotationValueForRendition]
(	@pkAnnotation decimal(18,0),
	@pkRendition decimal(18,0),
	@AnnotationValue Varchar(2000) output
)
as

Set @AnnotationValue = 
	(
	Select 	Coalesce(s.AnnotationValue,m.AnnotationValue,l.AnnotationValue,h.AnnotationValue) as 'AnnotationValue'
	From 	AnnotationValue a WITH (NOLOCK)
	Left Join AnnotationValueSmall s WITH (NOLOCK) on a.fkAnnotationValueSmall = s.pkAnnotationValueSmall
	Left Join AnnotationValueMedium m WITH (NOLOCK) on a.fkAnnotationValueMedium = m.pkAnnotationValueMedium
	Left Join AnnotationValueLarge l WITH (NOLOCK) on a.fkAnnotationValueLarge = l.pkAnnotationValueLarge
	Left Join AnnotationValueHuge h WITH (NOLOCK) on a.fkAnnotationValueHuge = h.pkAnnotationValueHuge
	Where 	a.fkAnnotation = @pkAnnotation
	and	a.fkRendition = @pkRendition
	)

