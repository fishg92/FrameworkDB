
--exec [GetFormAnnotationsLight] 3
CREATE proc [dbo].[GetFormAnnotationsLight]
	@pkFormName as decimal (18,0)
AS

select 
pkAnnotation = fa.pkFormAnnotation
, fa.AnnotationName
, fa.fkRefAnnotationType
, AnnotationTypeName = rat.Name
, PageNumber = fa.Page
, PositionX = p.x
, PositionY = p.y
, PositionWidth = p.Width
, PositionHeight = p.Height
, TabIndex = fa.AnnotationFormOrder
, fa.FontSize
, fa.DefaultText
, fa.NewLineAfter
from formAnnotation fa
	inner join FormAnnotationPosition p 
		on fa.pkFormAnnotation = p.fkFormAnnotation
	left join refAnnotationType rat
		on rat.pkRefAnnotationType = fa.fkRefAnnotationType
where 
	(fa.fkForm = @PkFormName or @PkFormName = -1)
	and
	(fa.deleted = 0)
