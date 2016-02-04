-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormComboValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormComboValueInsert]
(	  @ComboValue varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormComboValue decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormComboValue
(	  ComboValue
)
VALUES 
(	  @ComboValue

)

SET @pkFormComboValue = SCOPE_IDENTITY()
