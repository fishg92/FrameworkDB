create proc [dbo].[GetKeywordTypeForCompassPeopleKeyword]
	@CPKeywordName varchar(50)
as

select	fkKeywordType
from	KeywordTypeCPKeywordName
where	CPKeywordName = @CPKeywordName