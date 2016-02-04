-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormJoinFormFolderFormGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormFolderFormGroupDelete]
(	@pkFormJoinFormFolderFormGroup int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormJoinFormFolderFormGroup
WHERE 	pkFormJoinFormFolderFormGroup = @pkFormJoinFormFolderFormGroup
