
CREATE PROC [dbo].[usp_EnsureDocumentsConfigurationIntegrity] 
As

/* Per PCR 9243 scope extension.... if the user has turned on case tagging for a particular keyword, we need to make sure we enforce the NA rules for this special keyword */
declare @CaseTaggingKeyword varchar(50)

select @CaseTaggingKeyword = ItemValue from Configuration where itemKey = 'CaseTaggingKeyword'

if exists (select * from KeywordTypeDisplaySetting
			where rtrim(fkKeywordType)  = rtrim(@CaseTaggingKeyword)
			and (DisplayInResultGrid = 'True' or IsSearchable = 'True' or  IncludeInExportManifest = 'True')
			)
BEGIN
		update KeywordTypeDisplaySetting
			set DisplayInResultGrid = 'False'
				, IsSearchable = 'False'
				, IncludeInExportManifest = 'False'
		where rtrim(fkKeywordType)  = rtrim(@CaseTaggingKeyword)
END


