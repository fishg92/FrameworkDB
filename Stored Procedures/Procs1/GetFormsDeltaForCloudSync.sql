
CREATE PROCEDURE [dbo].[GetFormsDeltaForCloudSync]
(
	@pkConnectType decimal, 
	@includeImageData bit = 1
)

AS

declare @Forms table
(
	pkForm decimal,
	formName varchar (255),
	fkDocType varchar (50)
)

insert into @Forms
select distinct fn.pkFormName as pkForm
,fn.FriendlyName
,fkDocType = isnull(fn.FormDocType,'')
from 
 joineventtypeConnecttype jevtr 
inner join EventType et on jevtr.fkEventType = et.pkEventType
inner join JoinEventTypeFormName j on j.fkEventType = et.PkEventType
inner join Formname fn on j.fkFormName = fn.pkFormName
where jevtr.fkConnectType = @pkConnectType and fn.NotToDMS <> 1 and fn.Status = 1

select * from @Forms

IF (@includeImageData = 1)
	select f.pkForm,
			fip.pkFormImagePage,
			fip.ImageData,
			fip.PageNumber,
			fip.FileExtension 
	from @Forms f
	inner join FormImagePage fip on fip.fkFormName = f.pkForm
ELSE
	select f.pkForm,
			fip.pkFormImagePage,
			null as ImageData,
			fip.PageNumber,
			fip.FileExtension 
	from @Forms f
	inner join FormImagePage fip on fip.fkFormName = f.pkForm

select f.pkForm, pkAnnotation = fa.pkFormAnnotation, fa.AnnotationName, fa.FontSize, fa.Page, fa.fkrefAnnotationType, fap.width, 
fap.Height, fap.x, fap.y, fa.AnnotationFormOrder, fa.DefaultText, isnull(fa.Mask, '') Mask, fa.Required, fa.FontStyle, fa.FontColor, 
isnull(fa.SingleUse, 0) SingleUse, fa.fkFormAnnotationSharedObject, isnull(fa.ReadOnly, 0) ReadOnly, isnull(fa.Formula, '') Formula, 
fkFormComboName, fa.DefaultValue, NewLineAfter = isnull(fa.NewLineAfter,0)
from @Forms f
inner join FormAnnotation fa on fa.fkForm = f.pkForm
inner join FormAnnotationPosition fap on fap.fkFormAnnotation = fa.pkFormAnnotation
Left outer join FormAnnotationPosition fap2
  on (fa.pkFormAnnotation = fap2.fkFormAnnotation
  and (fap.pkFormAnnotationPosition < fap2.pkFormAnnotationPosition))
where fa.Deleted = 0
and fap2.pkFormAnnotationPosition is null