


create FUNCTION [dbo].[IsStringValue] (
  @OriginalValue  varchar(500)
, @CheckValue  varchar(500)
, @DefaultValue  varchar(500)
)
-- If the OriginalValue = CheckValue then return the default value
--		OTHERWISE, just return the original value
RETURNS   varchar(500) AS  
BEGIN 
declare @Return varchar(500)
if @OriginalValue = @CheckValue begin
	set @Return = @DefaultValue
end else begin
	set @Return = @OriginalValue
end

return @Return
END


