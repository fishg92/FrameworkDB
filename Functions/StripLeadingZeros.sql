


create FUNCTION [dbo].[StripLeadingZeros] (
  @OriginalValue  varchar(500)
)
-- If a value can be turned to numeric,
--	strip the leading zeros
RETURNS   varchar(500) AS  
BEGIN 
declare @Return varchar(500)
if isnumeric(@OriginalValue) = 1
	set @return = convert(varchar,convert(decimal(18,0),@OriginalValue))
else
	set @Return = @OriginalValue

return @Return
END


