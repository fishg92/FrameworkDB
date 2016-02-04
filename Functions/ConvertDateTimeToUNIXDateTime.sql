
CREATE FUNCTION [dbo].[ConvertDateTimeToUNIXDateTime] (@date datetime)
    RETURNS int
AS

BEGIN
    DECLARE @ret int
    SELECT @ret = DATEDIFF(second, '1970/01/01 00:00:00', @date)
     
    RETURN @ret
END
