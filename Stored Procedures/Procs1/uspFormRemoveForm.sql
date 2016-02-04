
-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormRemoveForm]
(
	  @pkFormName decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormName
	SET	[Status] = 4
	WHERE pkFormName = @pkFormName

	delete JoinEventTypeFormName
	where fkFormName = @pkFormName
