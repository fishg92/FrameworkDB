----------------------------------------------------------------------------
-- Select a single record from CPSmartFillKeywordMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPSmartFillKeywordMappingSelect]
(	@pkCPSmartFillKeywordMapping decimal(18, 0) = NULL,
	@PeopleKeyword varchar(100) = NULL,
	@SmartFillAlias varchar(100) = NULL
)
AS

SELECT	pkCPSmartFillKeywordMapping,
	PeopleKeyword,
	SmartFillAlias
FROM	CPSmartFillKeywordMapping
WHERE 	(@pkCPSmartFillKeywordMapping IS NULL OR pkCPSmartFillKeywordMapping = @pkCPSmartFillKeywordMapping)
 AND 	(@PeopleKeyword IS NULL OR PeopleKeyword LIKE @PeopleKeyword + '%')

