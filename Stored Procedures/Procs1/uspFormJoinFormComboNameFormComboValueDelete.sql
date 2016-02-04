-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormJoinFormComboNameFormComboValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormComboNameFormComboValueDelete]
(	@pkFormJoinFormComboNameFormComboValue int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormJoinFormComboNameFormComboValue
WHERE 	pkFormJoinFormComboNameFormComboValue = @pkFormJoinFormComboNameFormComboValue
