-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormQuickListSetParentFolder]
(
	@fkFormQuickListFolder decimal(10, 0),
	@pkFormQuickListFolder decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormQuickListFolder SET fkFormQuickListFolder = @fkFormQuickListFolder WHERE pkFormQuickListFolder = @pkFormQuickListFolder
