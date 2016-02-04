-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into Form
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormInsert]
(	  @FormName varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkForm decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Form
(	  FormName
)
VALUES 
(	  @FormName

)

SET @pkForm = SCOPE_IDENTITY()
