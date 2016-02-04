
----------------------------------------------------------------------------
-- Delete a single record from FormQuickListAdditionalStamp
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListAdditionalStampDelete]
(	@pkFormQuickListAdditionalStamp decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LupMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormQuickListAdditionalStamp
WHERE 	pkFormQuickListAdditionalStamp = @pkFormQuickListAdditionalStamp