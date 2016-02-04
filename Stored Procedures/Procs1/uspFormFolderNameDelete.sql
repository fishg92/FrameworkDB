-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormFolderName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormFolderNameDelete]
(	@pkFormFolderName int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormFolderName
WHERE 	pkFormFolderName = @pkFormFolderName
