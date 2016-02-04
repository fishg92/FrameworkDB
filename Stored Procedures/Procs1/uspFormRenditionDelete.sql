-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormRendition
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormRenditionDelete]
(	@pkFormRendition decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormRendition
WHERE 	pkFormRendition = @pkFormRendition
