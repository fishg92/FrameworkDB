-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormGroupName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormGroupNameInsert]
(	  @Name varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormGroupName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormGroupName
(	  Name
)
VALUES 
(	  @Name

)

SET @pkFormGroupName = SCOPE_IDENTITY()
