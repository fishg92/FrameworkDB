
CREATE PROCEDURE [dbo].[GetConcatenationFormAnnotationsGroupTypes]
	
AS

select pkFormAnnotationGroup, fkFormAnnotation, fag.Type from FormAnnotationGroup fag
inner join FormJoinFormAnnotationFormAnnotationGroup fjfafag on fag.pkFormAnnotationGroup = fjfafag.fkFormAnnotationGroup
inner join FormAnnotation fa on fa.pkFormAnnotation = fkFormAnnotation and fa.Deleted <> 1
where fag.Type in (2,4,5) and fkFormAnnotation is not null