
create FUNCTION [dbo].[ExtractZipPlus4]
(
	@RawZip varchar(20)
)
RETURNS varchar(5)
AS
BEGIN
	-- Declare the return variable here
	declare @ZipPlus4 varchar(4)
	
	set @RawZip = isnull(ltrim(rtrim(@RawZip)),'')
	set @RawZip = replace(@RawZip,' ','')
	set @RawZip = replace(@RawZip,'-','')
	set @RawZip = left(@RawZip,9)
	set @ZipPlus4 = substring(@RawZip,6,4)
	
	return @ZipPlus4
END
