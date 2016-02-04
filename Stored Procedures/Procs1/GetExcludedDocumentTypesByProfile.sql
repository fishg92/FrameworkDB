CREATE PROCEDURE [dbo].[GetExcludedDocumentTypesByProfile]
(	
	@profileId varchar(max)
)
AS	
	select fkDocumentType As DocumentTypeId 
	from DocumentTypeDisplaySetting
	where fkDocumentType not in (	
									select distinct fkDocumentType 
									from JoinProfileDocumentType 
									where fkProfile = @profileId
								)
