-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormGroupName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormGroupNameDelete]
(	@pkFormGroupName int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormGroupName
WHERE 	pkFormGroupName = @pkFormGroupName
