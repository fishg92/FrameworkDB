-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormComboName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormComboNameUpdate]
(	  @pkFormComboName int
	, @ComboName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormComboName
SET	ComboName = ISNULL(@ComboName, ComboName)
WHERE 	pkFormComboName = @pkFormComboName
