CREATE PROCEDURE [dbo].[uspFormNCPSystemSettingGet]
(
	  @AttributeName varchar(50)
	, @AttributeValue varchar(255) output
)
AS

	SET @AttributeValue = (SELECT TOP 1 AttributeValue FROM NCPSystem WHERE Attribute = @AttributeName AND Class = 'Forms')