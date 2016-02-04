


create FUNCTION [dbo].[fnSecureSSN](@rawSSN varchar(9))
RETURNS varchar(11)
AS
BEGIN
declare @return varchar(11)

if datalength(@rawSSN) = 9
	set @return = '***-**-' + substring(@rawSSN,6,4)
else
	set @return = replicate('*',datalength(@rawSSN))

return @return
END




