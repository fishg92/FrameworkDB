﻿-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormUserSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormUserSettingDelete]
(	  @pkFormUserSetting decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormUserSetting
WHERE 	pkFormUserSetting = @pkFormUserSetting
