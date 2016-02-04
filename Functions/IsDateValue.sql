



create FUNCTION [dbo].[IsDateValue] (
  @OriginalValue  datetime
, @CheckValue  datetime
, @DefaultValue  datetime
)
-- If the OriginalValue = CheckValue then return the default value
--		OTHERWISE, just return the original value
RETURNS   datetime AS  
BEGIN 
declare @Return datetime
if @OriginalValue = @CheckValue begin
	set @Return = @DefaultValue
end else begin
	set @Return = @OriginalValue
end

return @Return
END

