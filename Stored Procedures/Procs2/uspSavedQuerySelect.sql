


----------------------------------------------------------------------------
-- Select a single record from SavedQuery
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspSavedQuerySelect]
(	@pkSavedQuery decimal(10, 0) = NULL,
	@fkApplicationUser decimal(10, 0),
	@QueryName varchar(255) = NULL,
	@ExpirationDate smalldatetime = NULL
)
AS

if @fkApplicationUser is null
	raiserror('User ID must be provided to stored procedure uspSavedQuerySelect',16,1)

SELECT	pkSavedQuery,
	fkApplicationUser,
	QueryName,
	ExpirationDate
	,Notes
FROM	SavedQuery
WHERE 	(@pkSavedQuery IS NULL OR pkSavedQuery = @pkSavedQuery)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@QueryName IS NULL OR QueryName LIKE @QueryName + '%')
 AND 	(@ExpirationDate IS NULL OR ExpirationDate = @ExpirationDate)


