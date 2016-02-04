create   FUNCTION [dbo].[fnSSNIsException](
	@SSN varchar(20)
)

RETURNS bit
AS
BEGIN
	DECLARE @return bit
	set @return = 0
	
	if exists (	select	*
				from	Configuration
				where	ItemKey like 'SSNException%'
				and		rtrim(replace(ItemValue,'-','')) = dbo.StripPhone(@SSN)
				)
		begin
		set @return = 1
		end
	
	return @return
END	
	
