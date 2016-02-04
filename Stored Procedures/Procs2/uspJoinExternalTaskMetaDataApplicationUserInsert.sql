----------------------------------------------------------------------------
-- Insert a single record into JoinExternalTaskMetaDataApplicationUser
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinExternalTaskMetaDataApplicationUserInsert]
(	  @fkExternalTaskMetaData decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @UserRead bit = NULL
	, @UserReadNote bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinExternalTaskMetaDataApplicationUser decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinExternalTaskMetaDataApplicationUser
(	  fkExternalTaskMetaData
	, fkApplicationUser
	, UserRead
	, UserReadNote
)
VALUES 
(	  @fkExternalTaskMetaData
	, @fkApplicationUser
	, COALESCE(@UserRead, (0))
	, COALESCE(@UserReadNote, (0))

)

SET @pkJoinExternalTaskMetaDataApplicationUser = SCOPE_IDENTITY()
