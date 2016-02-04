-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormNCPSystemSettingSave]
(
	  @AttributeName varchar(50)
	, @AttributeValue varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine
	IF EXISTS(SELECT * FROM NCPSystem WHERE Attribute = @AttributeName AND Class = 'Forms')
	BEGIN
		UPDATE NCPSystem SET AttributeValue = @AttributeValue WHERE Attribute = @AttributeName AND Class = 'Forms'
	END
	ELSE
	BEGIN
		INSERT INTO NCPSystem(Attribute, AttributeValue, Class) VALUES(@AttributeName, @AttributeValue, 'Forms')
	END
