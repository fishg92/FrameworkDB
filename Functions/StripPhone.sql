
create FUNCTION [dbo].[StripPhone]
(
	@PhoneRaw varchar(20)
)
RETURNS varchar(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PhoneStripped varchar(10)
	
	set @PhoneRaw = isnull(@PhoneRaw,'')
	set @PhoneRaw = ltrim(rtrim(@PhoneRaw))
	set @PhoneRaw = replace(@PhoneRaw,'-','')
	set @PhoneRaw = replace(@PhoneRaw,' ','')
	set @PhoneRaw = replace(@PhoneRaw,'(','')
	set @PhoneRaw = replace(@PhoneRaw,')','')
	set @PhoneRaw = replace(@PhoneRaw,'.','')

	set @PhoneStripped = substring(@PhoneRaw,1,10)	
		
	return @PhoneStripped

END
