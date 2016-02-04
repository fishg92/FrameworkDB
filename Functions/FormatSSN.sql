
CREATE FUNCTION [dbo].[FormatSSN]
(
	@SSNRaw varchar(20)
)
RETURNS varchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SSNFormatted varchar(20)
	
	set @SSNRaw = isnull(@SSNRaw,'')
	set @SSNRaw = ltrim(rtrim(@SSNRaw))
	set @SSNRaw = replace(@SSNRaw,'-','')
	set @SSNRaw = replace(@SSNRaw,' ','')
	
	if datalength(@SSNRaw) = 9
		set @SSNFormatted = 
			substring(@SSNRaw,1,3) 
			+ '-' + substring(@SSNRaw,4,2)
			+ '-' + substring(@SSNRaw,6,4)
	else
		set @SSNFormatted = @SSNRaw
		
	return @SSNFormatted	

END
