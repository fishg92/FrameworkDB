

Create FUNCTION [dbo].[fnNorthwoodsNumber]
	(
		@pkCPClient decimal
	)
RETURNS varchar(14)
AS
BEGIN
	/**********************************
	Calculate the NorthwoodsNumber value
	from the pkCPClient value
	**********************************/
	declare @return varchar(14)
			,@CountyCode varchar(5)

	select	@CountyCode = AttributeValue
	from	dbo.NCPSystem
	where	Class = 'Forms'
	and		Attribute = 'CountyCode'

	set @return = @CountyCode
				+ replicate('0',14 - datalength(@CountyCode) - datalength(convert(varchar,@pkCPClient)))
				+ convert(varchar,@pkCPClient)

	return @return
END


