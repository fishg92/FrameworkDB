-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormFolder
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormFolderDelete]
(	@pkFormFolder int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormFolder
WHERE 	pkFormFolder = @pkFormFolder
