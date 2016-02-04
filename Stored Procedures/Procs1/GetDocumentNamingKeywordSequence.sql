CREATE proc [dbo].[GetDocumentNamingKeywordSequence]
as

select	fkKeywordType
from	KeywordTypeDisplaySetting
where	fkProfile = -1
and		DocumentNamingSequence <> -1
order by DocumentNamingSequence
