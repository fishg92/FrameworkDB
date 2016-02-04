
CREATE PROCEDURE GetQuickListFolderNameFromFormName(
	@pkFormQuickListFormName as decimal(18,0)
	,@pkApplicationUser as decimal(18,0)

)

AS
BEGIN
	
	SET NOCOUNT ON

	Select fldrname.QuickListFolderName 
	FROM FormJoinQuickListFormFolderQuickListFormName fn
	INNER JOIN FormQuickListFolder fldr 
		ON fn.fkFormQuickListFolder=fldr.pkFormQuickListFolder 
	INNER JOIN FormQuickListFolderName fldrname
		ON fldrname.pkFormQuickListFolderName=fldr.fkFormQuickListFolderName
	INNER JOIN FormQuickListFormName fqlfn
		on fqlfn.pkFormQuickListFormName = fn.fkFormQuickListFormName
	WHERE fn.fkFormQuickListFormName=@pkFormQuickListFormName AND fqlfn.fkFormUser=@pkApplicationUser

	set nocount off

END