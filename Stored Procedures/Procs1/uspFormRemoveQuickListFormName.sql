CREATE PROCEDURE [dbo].[uspFormRemoveQuickListFormName]
(	  @pkFormQuickListFormName decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
)
AS
    Declare @LUPMachine varchar(15)
	select @LUPMachine = NULL

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormQuickListFormName
	SET Inactive = 1 
	WHERE pkFormQuickListFormName = @pkFormQuickListFormName
