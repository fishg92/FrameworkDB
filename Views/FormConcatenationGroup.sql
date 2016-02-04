CREATE view [dbo].[FormConcatenationGroup]
AS
select
	pkFormAnnotationGroup as GroupId, [Type] as GroupType
from FormAnnotationGroup
where
	[Type] in (2 /*left*/, 3 /*right*/, 4 /*up-retain-spaces*/, 5 /*up-remove-spaces*/)