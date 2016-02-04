create proc [dbo].[GetRecipientMappingKeywordType] 
	@pkProfile decimal
as

select	RecipientMappingKeywordType
from	Profile
where	pkProfile = @pkProfile