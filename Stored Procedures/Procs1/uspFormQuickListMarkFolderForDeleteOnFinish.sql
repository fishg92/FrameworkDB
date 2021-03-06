﻿-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormQuickListMarkFolderForDeleteOnFinish]
(
	  @pkFormQuickListFolder decimal(18,0)
	, @OnOff bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)


) AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE FormQuickListFolder SET DeleteOnFinish = @OnOff WHERE pkFormQuickListFolder = @pkFormQuickListFolder
