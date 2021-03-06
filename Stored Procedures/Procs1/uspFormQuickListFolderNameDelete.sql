﻿-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormQuickListFolderName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormQuickListFolderNameDelete]
(	@pkFormQuickListFolderName int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormQuickListFolderName
WHERE 	pkFormQuickListFolderName = @pkFormQuickListFolderName
