-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinFormComboNameFormComboValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormComboNameFormComboValueInsert]
(	  @fkFormComboName decimal(10, 0)
	, @fkFormComboValue decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormComboNameFormComboValue decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinFormComboNameFormComboValue
(	  fkFormComboName
	, fkFormComboValue
)
VALUES 
(	  @fkFormComboName
	, @fkFormComboValue

)

SET @pkFormJoinFormComboNameFormComboValue = SCOPE_IDENTITY()
