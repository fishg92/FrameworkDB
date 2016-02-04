





create    FUNCTION [dbo].[myGetDate]  ()

RETURNS  datetime 
as
begin

return (Select CurrentDate from dbo.vGetdate)
end




