

/****** Object:  StoredProcedure [dbo].[PopulateJoinProfileDocumentType]    Script Date: 07/31/2013 15:00:21 ******/

Create  procedure [dbo].[PopulateJoinProfileDocumentType]
as

	DECLARE @Profile VARCHAR(50) -- ProfileId  
	DECLARE @DocumentType VARCHAR(50) -- DocumentTypeId  
	
	DECLARE DocumentTypeCollection CURSOR FOR
		Select fkDocumentType
		from dbo.DocumentTypeDisplaySetting 
		
	DECLARE ProfileCollection CURSOR FOR
		Select pkProfile from Profile
		
	DECLARE ExcludeProfileCollection CURSOR FOR
		Select Itemvalue, fkProfile from ProfileSetting
		where grouping = 'ProfileDocumentType'

	open DocumentTypeCollection
	FETCH NEXT from DocumentTypeCollection INTO @DocumentType
	
	While @@FETCH_STATUS = 0
		BEGIN
			open ProfileCollection
			
			FETCH NEXT from ProfileCollection INTO @Profile
				While @@FETCH_STATUS = 0
				BEGIN
						insert into dbo.JoinProfileDocumentType
						(fkProfile, fkDocumentType)
						Values 
						(@Profile, @DocumentType)
					FETCH NEXT from ProfileCollection INTO @Profile
				END
				Close ProfileCollection
				
				FETCH NEXT from DocumentTypeCollection INTO @DocumentType
				
		END
		
		Close DocumentTypeCollection
		DEALLOCATE DocumentTypeCollection
		DEALLOCATE ProfileCollection
		
		open ExcludeProfileCollection
		FETCH NEXT from ExcludeProfileCollection INTO @DocumentType, @Profile
		
		While @@FETCH_STATUS = 0
		BEGIN
			Delete dbo.JoinProfileDocumentType
			where fkDocumentType = @DocumentType and  fkProfile = @Profile
			FETCH NEXT from ExcludeProfileCollection INTO @DocumentType, @Profile
		END
 
		Close ExcludeProfileCollection
		DEALLOCATE ExcludeProfileCollection
