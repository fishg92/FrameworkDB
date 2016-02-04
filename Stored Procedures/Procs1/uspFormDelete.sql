-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from Form
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormDelete]
(	@pkForm int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	Form
WHERE 	pkForm = @pkForm
