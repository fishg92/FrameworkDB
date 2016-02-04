
CREATE PROCEDURE [getCoPilotSyncFormFavorites] (
	@pkApplicationUser as decimal(18,0) )
AS
BEGIN
	
	SET NOCOUNT ON;

	-- get distinct form ids
	select distinct fname.pkFormQuickListFormName,fname.*,formn.FormDocType
	from formquicklistfolder folder
	inner join FormQuickListFolderName name 
		on folder.fkFormQuickListFolderName = name.pkFormQuickListFolderName
	inner join FormJoinQuickListFormFolderQuickListFormName JFF 
		on jff.fkFormQuickListFolder = folder.pkFormQuickListFolder
	inner join FormQuickListFormName fname 
		on fname.pkFormQuickListFormName = jff.fkFormQuickListFormName
	inner join formname formn on formn.pkFormName = fname.fkFormName
	where name.QuickListFolderName = 'CoPilot_Sync'
		and fname.fkFormUser = @pkApplicationUser 
		and fname.Inactive = 0
		and (fname.fkCPClientCase is not null and fname.fkCPClient is not null)
 
END