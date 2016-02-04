CREATE PROCEDURE [dbo].[GetIncludedDocumentTypesByProfile]
(	
	@profileId decimal(18,0)
)
AS
	select fkDocumentType As DocumentTypeId 
	from DocumentTypeDisplaySetting
	where fkDocumentType in (	
								select distinct fkDocumentType 
								from JoinProfileDocumentType 
								where fkProfile = @profileId
							)
