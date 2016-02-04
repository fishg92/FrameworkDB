
CREATE proc [dbo].[GetUserNamesforQuickListForms]
	@fkFormName decimal
as

SELECT LastName, FirstName, UserName FROM dbo.ApplicationUser WHERE pkApplicationUser IN (
SELECT Distinct(fkFormUser) FROM dbo.FormQuickListFormName
WHERE fkFormName = @fkFormName AND Inactive = 0)
ORDER BY LastName asc
