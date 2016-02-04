CREATE     procedure [dbo].[GetProfileKeywordsByProfile]
(	@pkProfile decimal(18,0)
)
as
	Select ItemKey, ItemValue 
	from ProfileSetting (nolock)
	Where fkProfile = @pkProfile
	and [Grouping] = 'KeywordSettings'

