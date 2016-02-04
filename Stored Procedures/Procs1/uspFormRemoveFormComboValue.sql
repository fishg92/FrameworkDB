-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormRemoveFormComboValue]
(	  @pkFormComboName decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DELETE FROM FormComboValue 
	WHERE pkFormComboValue IN (
		SELECT DISTINCT j.fkFormComboValue 
		FROM FormJoinFormComboNameFormComboValue j 
		WHERE j.fkFormComboName = @pkFormComboName
	)

	DELETE FROM FormJoinFormComboNameFormComboValue
	WHERE fkFormComboName = @pkFormComboName
