----------------------------------------------------------------------------
-- Delete all records from FormUserSharedObject with specific fkFormAnnotationSharedObject value
----------------------------------------------------------------------------
CREATE PROC [dbo].[DeleteFormUserSharedObjectByPkSharedObject]
(	@fkFormAnnotationSharedObject decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormUserSharedObject
WHERE 	fkFormAnnotationSharedObject = @fkFormAnnotationSharedObject
