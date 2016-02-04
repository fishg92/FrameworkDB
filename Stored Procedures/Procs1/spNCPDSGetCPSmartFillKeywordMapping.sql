
create  proc [dbo].[spNCPDSGetCPSmartFillKeywordMapping]
as

Select 	pkCPSmartFillKeywordMapping,
	PeopleKeyword,
	SmartFillAlias
From	CPSmartFillKeywordMapping
