

----------------------------------------------------------------------------
-- Select a single record from SavedQueryCriteria
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspSavedQueryCriteriaSelect]
(	@pkSavedQueryCriteria decimal(10, 0) = NULL,
	@fkSavedQuery decimal(10, 0) = NULL,
	@fkKeyword varchar(50) = NULL,
	@KeywordValue varchar(50) = NULL,
	@KeywordStartDate smalldatetime = NULL,
	@KeywordEndDate smalldatetime = NULL
)
AS

SELECT	pkSavedQueryCriteria,
	fkSavedQuery,
	fkKeyword,
	KeywordValue,
	KeywordStartDate,
	KeywordEndDate
FROM	SavedQueryCriteria
WHERE 	(@pkSavedQueryCriteria IS NULL OR pkSavedQueryCriteria = @pkSavedQueryCriteria)
 AND 	(@fkSavedQuery IS NULL OR fkSavedQuery = @fkSavedQuery)
 AND 	(@fkKeyword IS NULL OR fkKeyword = @fkKeyword)
 AND 	(@KeywordValue IS NULL OR KeywordValue LIKE @KeywordValue + '%')
 AND 	(@KeywordStartDate IS NULL OR KeywordStartDate = @KeywordStartDate)
 AND 	(@KeywordEndDate IS NULL OR KeywordEndDate = @KeywordEndDate)

