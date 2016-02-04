create proc [dbo].[ClearAllDocumentNamingSequence]

as

update	KeywordTypeDisplaySetting
set		DocumentNamingSequence = -1
where	DocumentNamingSequence <> -1
and		fkProfile = -1



--create proc GetDocumentNamingKeywordSequence
--as

--select	fkKeywordType
--		,DocumentNamingSequence
--from	KeywordTypeDisplaySetting
--where	fkProfile = -1
--and		DocumentNamingSequence <> -1
--order by DocumentNamingSequence
