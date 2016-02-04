-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormComboValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormComboValueDelete]
(	@pkFormComboValue int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormComboValue
WHERE 	pkFormComboValue = @pkFormComboValue
