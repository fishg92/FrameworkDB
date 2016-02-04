CREATE VIEW [dbo].[FormFavorite]
AS
select
  ffname.pkFormQuickListFormName as FormFavoriteId, folder.fkFormUser as ApplicationUserId, ffname.fkCPClient as ClientId,
  ffname.fkCPClientCase as CaseId, ffname.QuickListFormName as FormFavoriteName, ffname.DateAdded,
  ffname.fkFormName as FormTemplateId, fname.FormDocType as DocumentTypeId,
  foldername.QuickListFolderName as FolderName
from FormQuickListFormName ffname
inner join FormName fname
	on fname.pkFormName = ffname.fkFormName
inner join FormJoinQuickListFormFolderQuickListFormName j
	on j.fkFormQuickListFormName = ffname.pkFormQuickListFormName
inner join FormQuickListFolder folder
	on folder.pkFormQuickListFolder = j.fkFormQuickListFolder
inner join FormQuickListFolderName foldername
	on foldername.pkFormQuickListFolderName = folder.fkFormQuickListFolderName
where
	ffname.Inactive = 0