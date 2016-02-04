CREATE view [dbo].[FormTemplateAnnotation]
as
with ConcatenatedAnnotations as 
(
	select g.GroupId, ag.fkFormAnnotation as AnnotationId from
	FormConcatenationGroup g
 	join FormJoinFormAnnotationFormAnnotationGroup ag on g.GroupId = ag.fkFormAnnotationGroup
)
select
	a.pkFormAnnotation as FormTemplateAnnotationId, a.fkForm as FormTemplateId,
	a.AnnotationName as Name, a.fkrefAnnotationType as AnnotationType,
	a.Formula, a.fkFormComboName as ComboListId, a.Page as PageNumber,
	a.Mask, a.Required, a.SingleUse, a.FontSize, a.FontStyle, a.FontColor, a.AnnotationFormOrder as TabOrder,
	a.DefaultText, a.DefaultValue, a.fkFormAnnotationSharedObject as SharedObjectId,
	ap.x as X, ap.y as Y, ap.Height, ap.Width,
	ca.GroupId as FormConcatenationGroupId, NewLineAfter = isnull(a.NewLineAfter, 0)
from FormAnnotation a
join FormAnnotationPosition ap
	on ap.fkFormAnnotation = a.pkFormAnnotation
left join ConcatenatedAnnotations ca
	on ca.AnnotationId = a.pkFormAnnotation
where
	a.Deleted = 0