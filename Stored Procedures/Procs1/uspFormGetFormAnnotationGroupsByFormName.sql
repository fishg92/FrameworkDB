CREATE PROCEDURE [dbo].[uspFormGetFormAnnotationGroupsByFormName]
(
	@pkFormName decimal(18,0)
)
AS

	SELECT DISTINCT fg.* FROM FormAnnotationGroup fg 
	JOIN FormJoinFormAnnotationFormAnnotationGroup fj ON fj.fkFormAnnotationGroup = fg.pkFormAnnotationGroup
	WHERE fj.fkForm = @pkFormName
