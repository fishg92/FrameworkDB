-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from UserSettings
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspUserSettingsDelete]
(	@pkUserSettings int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	UserSettings
WHERE 	pkUserSettings = @pkUserSettings
