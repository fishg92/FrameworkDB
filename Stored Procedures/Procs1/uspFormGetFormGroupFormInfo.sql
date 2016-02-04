CREATE PROCEDURE [dbo].[uspFormGetFormGroupFormInfo]
(	
	@pkFormGroup decimal(18,0)
)
AS

SELECT 		fn.FriendlyName, fn.SystemName, gfn.pkFormJoinFormNameFormGroup, gfn.fkFormName, gfn.fkFormJoinFormNameFormGroupParent, gfn.Copies, fn.Status, ISNULL(gpn.FriendlyName, '') AS 'ParentFriendlyName'
FROM 		FormGroup fg
JOIN		FormGroupName gn ON fg.fkFormGroupName = gn.pkFormGroupName
JOIN		FormJoinFormNameFormGroup gfn ON fg.pkFormGroup = gfn.fkFormGroup
JOIN		FormName fn ON gfn.fkFormName = fn.pkFormName
LEFT JOIN	FormJoinFormNameFormGroup gfnInherit ON gfn.fkFormJoinFormNameFormGroupParent = gfnInherit.pkFormJoinFormNameFormGroup
LEFT JOIN	FormName gpn ON gpn.pkFormName = gfnInherit.fkFormName
WHERE		fg.pkFormGroup = @pkFormGroup
ORDER BY	gfn.FormOrder ASC