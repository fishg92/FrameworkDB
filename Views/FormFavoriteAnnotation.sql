CREATE view [dbo].[FormFavoriteAnnotation] as
select
	a.pkFormAnnotation as FormTemplateAnnotationId, ff.pkFormQuickListFormName as FormFavoriteId,
	av.AnnotationValue as Value, a.NewLineAfter
from FormAnnotation a
join FormName f on f.pkFormName = a.fkForm
join FormAnnotationPosition ap
	on ap.fkFormAnnotation = a.pkFormAnnotation
join FormQuickListFormName ff on ff.fkFormName = f.pkFormName
left join FormJoinQuickListFormNameAnnotationAnnotationValue av
	on av.fkQuickListFormName = ff.pkFormQuickListFormName
	and av.fkFormAnnotation = a.pkFormAnnotation
where
	a.Deleted = 0
