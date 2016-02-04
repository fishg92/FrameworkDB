-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormEditComboName]
(	  @pkFormComboName decimal(18, 0)
	, @ComboName varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormComboName
	SET ComboName = @ComboName
	WHERE pkFormComboName = @pkFormComboName
