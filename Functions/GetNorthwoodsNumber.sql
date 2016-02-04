CREATE function dbo.GetNorthwoodsNumber
(
	@Identity numeric(18,0)
)

	Returns Varchar(20)


as
begin

	Declare @CountyCode varchar(20)
	Set @CountyCode = (Select Max(AttributeValue) from NCPSystem where Attribute = 'CountyCode')


	Declare @PaddedValue varchar(20)
	set @PaddedValue = Replicate('0',9 - len(convert(Varchar(20),@Identity))) + convert(varchar(20),@Identity)

	Declare @NorthwoodsNumber varchar(20)
	Set @NorthwoodsNumber = @CountyCode + @PaddedValue

	Return @NorthwoodsNumber
end
		

