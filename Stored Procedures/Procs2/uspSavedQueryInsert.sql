-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into SavedQuery
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSavedQueryInsert]
	  @fkApplicationUser decimal(10, 0)
	, @QueryName varchar(255)
	, @ExpirationDate smalldatetime = NULL
	, @Notes varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkSavedQuery decimal(10, 0) = NULL OUTPUT 
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT SavedQuery
(	  fkApplicationUser
	, QueryName
	, ExpirationDate
	, Notes
)
VALUES 
(	  @fkApplicationUser
	, @QueryName
	, @ExpirationDate
	, @Notes

)

SET @pkSavedQuery = SCOPE_IDENTITY()
