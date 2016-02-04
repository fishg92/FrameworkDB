CREATE PROCEDURE [dbo].[uspFormQuicklistGetFolderJoins]
(
	@fkFormUser decimal(18,0)
)
AS

SELECT    j.pkFormJoinQuickListFormFolderQuickListFormName
		, j.fkFormQuickListFolder
		, j.fkFormQuickListFormName
FROM FormJoinQuickListFormFolderQuickListFormName j
JOIN FormQuickListFormName f ON j.fkFormQuickListFormName = f.pkFormQuickListFormName
WHERE f.fkFormUser = @fkFormUser