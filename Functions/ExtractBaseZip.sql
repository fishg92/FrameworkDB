
CREATE FUNCTION [dbo].[ExtractBaseZip]
(
	@RawZip varchar(20)
)
RETURNS varchar(5)
AS
BEGIN
	-- Declare the return variable here
	declare @BaseZip varchar(5)
	
	set @RawZip = isnull(ltrim(rtrim(@RawZip)),'')
	set @RawZip = replace(@RawZip,' ','')
	set @RawZip = replace(@RawZip,'-','')
	set @BaseZip = left(@RawZip,5)
	
	return @BaseZip
END
