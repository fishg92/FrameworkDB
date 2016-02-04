
--select dbo.[fnGetNumericConfigurationValue]('PublicSessionTimeoutInMinutes',-1,60)

CREATE FUNCTION [dbo].[fnGetNumericConfigurationValue]
	(@ItemKey varchar(100)
	, @AppID decimal
	, @Default decimal)
RETURNS decimal
AS
BEGIN

	if exists (select * from Configuration where appid = @AppID and ItemKey = @ItemKey) BEGIN
		select @Default = 
			cast(ItemValue as decimal) 
				from Configuration where appid = @AppID 
									and ItemKey = @ItemKey
	END

RETURN 	@Default

END


