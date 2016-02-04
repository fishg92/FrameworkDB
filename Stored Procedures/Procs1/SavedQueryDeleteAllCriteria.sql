CREATE proc [dbo].[SavedQueryDeleteAllCriteria]
	@pkSavedQuery decimal
as

delete	SavedQueryCriteria
where	fkSavedQuery = @pkSavedQuery