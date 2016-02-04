
CREATE FUNCTION [dbo].[fnGetAutoFillViewName]
(
	@pkAutoFillView int
) 
RETURNS varchar(255)
AS
BEGIN
	DECLARE @Ret varchar(255)


	Select @Ret = FriendlyName from AutoFillSchemaDataView WHERE pkAutoFillSchemaDataView = @pkAutoFillView
		
		set @Ret = replace(@Ret,'[dbo].','')
		set @Ret = replace(@Ret,'dbo.','')

		if substring(@Ret,1,1) = '[' BEGIN
			set @Ret = substring(@Ret,2,len(@Ret)-1)
			if substring(@Ret,len(@ret),1) = ']' BEGIN
				set @Ret = substring(@Ret,1,len(@Ret)-1)
			END
		END
	
	RETURN @Ret
END
