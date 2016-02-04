-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from SmartFillData
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSmartFillDataDelete]
(	@pkUser decimal(18, 0)
	, @clientCompassID varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	dbo.SmartFillData
WHERE 	PeopleID = @clientCompassID AND fkApplicationUser = @pkUser
