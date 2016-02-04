-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinFormComboNameFormComboValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormComboNameFormComboValueUpdate]
(	  @pkFormJoinFormComboNameFormComboValue decimal(10, 0)
	, @fkFormComboName decimal(10, 0) = NULL
	, @fkFormComboValue decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinFormComboNameFormComboValue
SET	fkFormComboName = ISNULL(@fkFormComboName, fkFormComboName),
	fkFormComboValue = ISNULL(@fkFormComboValue, fkFormComboValue)
WHERE 	pkFormJoinFormComboNameFormComboValue = @pkFormJoinFormComboNameFormComboValue
