----------------------------------------------------------------------------
-- Select a single record from JoinExternalTaskMetaDataApplicationUser
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinExternalTaskMetaDataApplicationUserSelect]
(	@pkJoinExternalTaskMetaDataApplicationUser decimal(18, 0) = NULL,
	@fkExternalTaskMetaData decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@UserRead bit = NULL,
	@UserReadNote bit = NULL
)
AS

SELECT	pkJoinExternalTaskMetaDataApplicationUser,
	fkExternalTaskMetaData,
	fkApplicationUser,
	UserRead,
	UserReadNote
FROM	JoinExternalTaskMetaDataApplicationUser
WHERE 	(@pkJoinExternalTaskMetaDataApplicationUser IS NULL OR pkJoinExternalTaskMetaDataApplicationUser = @pkJoinExternalTaskMetaDataApplicationUser)
 AND 	(@fkExternalTaskMetaData IS NULL OR fkExternalTaskMetaData = @fkExternalTaskMetaData)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@UserRead IS NULL OR UserRead = @UserRead)
 AND 	(@UserReadNote IS NULL OR UserReadNote = @UserReadNote)

