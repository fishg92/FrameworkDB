Create FUNCTION [dbo].[DatePortion]  (
	@Date datetime
)

RETURNS  datetime 
as
begin
return convert(datetime,convert(varchar(10),@Date,101))
end





