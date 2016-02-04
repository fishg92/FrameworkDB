CREATE PROCEDURE [dbo].[DeleteIncludedDocumentTypeByProfile]
(
	@profileId as decimal(18,0),
	@documentTypeId as varchar(50)
)
AS
	if(exists(select * from JoinProfileDocumentType where fkProfile = @profileId and fkDocumentType = @documentTypeId))
	BEGIN	
		delete from JoinProfileDocumentType
		where fkProfile = @profileId and 
		fkDocumentType = @documentTypeId
	END
