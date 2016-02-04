-- Stored Procedure

CREATE proc [dbo].[uspFormEditQuickListFormName]
(	 @QuickListFormName varchar(255)
	,@FormOrder int = NULL
	,@pkQuickListFormName decimal(10, 0) 
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormQuickListFormName
	SET 	 QuickListFormName = @QuickListFormName
		,FormOrder = ISNULL(@FormOrder, FormOrder)
	WHERE pkFormQuickListFormName = @pkQuickListFormName
