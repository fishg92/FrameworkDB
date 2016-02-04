-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from ProfileSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProfileSettingDelete]
(	@pkProfileSetting int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	ProfileSetting
WHERE 	pkProfileSetting = @pkProfileSetting
