CREATE proc [dbo].[SplitZipCode]
	@inputZip varchar(10)
	,@inputPlus4 varchar(4) = null
	,@outputZip varchar(5) output
	,@outputPlus4 varchar(4) output
as

/*******************************************
This procedure will take inputs of ZIP codes in various
formats and standardize the output to a 5-digit main ZIP
code and a 4-digit Plus4 suffix.
*******************************************/
set @inputZip = isnull(@inputZip,'')
set @inputZip = ltrim(rtrim(@InputZip))
set @inputZip = replace(replace(@inputZip,' ',''),'-','')

set @inputPlus4 = isnull(@inputPlus4,'')
set @inputPlus4 = ltrim(rtrim(@inputPlus4))
set @inputPlus4 = replace(@inputPlus4,' ','')

set @outputZip = ''
set @outputPlus4 = ''

declare @combinedZip varchar(14)
set @combinedZip = @inputZip + @inputPlus4

--if datalength(@combinedZip) <= 5
--	begin
--	set @outputZip = @combinedZip
--	end
--else
--	begin
	set @outputZip = substring(@combinedZip,1,5)
	set @outputPlus4 = substring(@combinedZip,6,4)
	--end