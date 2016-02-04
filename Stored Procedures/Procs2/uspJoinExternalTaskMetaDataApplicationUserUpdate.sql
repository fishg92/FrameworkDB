----------------------------------------------------------------------------
-- Update a single record in JoinExternalTaskMetaDataApplicationUser
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinExternalTaskMetaDataApplicationUserUpdate]
(	  @pkJoinExternalTaskMetaDataApplicationUser decimal(18, 0)
	, @fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @UserRead bit = NULL
	, @UserReadNote bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinExternalTaskMetaDataApplicationUser
SET	fkExternalTaskMetaData = ISNULL(@fkExternalTaskMetaData, fkExternalTaskMetaData),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	UserRead = ISNULL(@UserRead, UserRead),
	UserReadNote = ISNULL(@UserReadNote, UserReadNote)
WHERE 	pkJoinExternalTaskMetaDataApplicationUser = @pkJoinExternalTaskMetaDataApplicationUser
