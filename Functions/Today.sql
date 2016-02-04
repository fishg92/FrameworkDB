CREATE FUNCTION [dbo].[Today]  ()

RETURNS  datetime 
as
begin
return convert(datetime,convert(varchar(10),(select CurrentDate from dbo.vGetdate),101))
end
