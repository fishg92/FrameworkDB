create proc [dbo].[SaveDocumentNamingSequenceItem]
	@fkKeywordType varchar(50)
	,@DocumentNamingSequence int
as

update	KeywordTypeDisplaySetting
set		DocumentNamingSequence = @DocumentNamingSequence
where	fkKeywordType = @fkKeywordType
and		fkProfile = -1



--create proc GetDocumentNamingKeywordSequence
--as

--select	fkKeywordType
--		,DocumentNamingSequence
--from	KeywordTypeDisplaySetting
--where	fkProfile = -1
--and		DocumentNamingSequence <> -1
--order by DocumentNamingSequence
