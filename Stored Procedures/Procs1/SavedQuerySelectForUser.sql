


----------------------------------------------------------------------------
-- Select a single record from SavedQuery
----------------------------------------------------------------------------
create PROC [dbo].[SavedQuerySelectForUser]
	@fkApplicationUser decimal(10, 0)
AS

SELECT	pkSavedQuery,
	fkApplicationUser,
	QueryName,
	ExpirationDate
	,Notes
FROM	SavedQuery
WHERE 	fkApplicationUser  = @fkApplicationUser

SELECT	c.pkSavedQueryCriteria
		,c.fkSavedQuery
		,c.fkKeyword
		,c.KeywordValue
		,c.KeywordStartDate
		,c.KeywordEndDate
FROM	SavedQueryCriteria c
join SavedQuery s
	on c.fkSavedQuery = s.pkSavedQuery
where s.fkApplicationUser = @fkApplicationUser

