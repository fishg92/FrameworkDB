CREATE PROCEDURE [dbo].[InsertIncludedDocumentTypeByProfile]
(
	@profileId as decimal(18,0),
	@documentTypeId as varchar(50)
)
AS
	if(not exists(select * from JoinProfileDocumentType where fkProfile = @profileId and fkDocumentType = @documentTypeId))
	BEGIN	
		insert JoinProfileDocumentType (fkProfile, fkDocumentType)
		Values (@profileId, @documentTypeId)
	END
