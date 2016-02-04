-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormPath
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormPathDelete]
(	@pkFormPath int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS



exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormPath
WHERE 	pkFormPath = @pkFormPath
