-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormComboName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormComboNameInsert]
(	  @ComboName varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormComboName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormComboName
(	  ComboName
)
VALUES 
(	  @ComboName

)

SET @pkFormComboName = SCOPE_IDENTITY()
