-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormComboName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormComboNameDelete]
(	@pkFormComboName int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormComboName
WHERE 	pkFormComboName = @pkFormComboName
