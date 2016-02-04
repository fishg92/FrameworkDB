-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormComboValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormComboValueUpdate]
(	  @pkFormComboValue int
	, @ComboValue varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormComboValue
SET	ComboValue = ISNULL(@ComboValue, ComboValue)
WHERE 	pkFormComboValue = @pkFormComboValue
