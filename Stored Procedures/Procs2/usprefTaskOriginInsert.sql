----------------------------------------------------------------------------
-- Insert a single record into refTaskOrigin
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskOriginInsert]
(	  @TaskOriginName varchar(150)
	, @Active bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskOrigin decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskOrigin
(	  TaskOriginName
	, Active
)
VALUES 
(	  @TaskOriginName
	, COALESCE(@Active, 'True')

)

SET @pkrefTaskOrigin = SCOPE_IDENTITY()
