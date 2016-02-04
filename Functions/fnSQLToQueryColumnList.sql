
/*
select dbo.[fnSQLToQueryColumnList](17)
*/

CREATE FUNCTION [dbo].[fnSQLToQueryColumnList](@pkAutofillSchemaDataview decimal)
RETURNS varchar(max)
AS
BEGIN
 DECLARE @ReturnValue varchar(max)
  
select @ReturnValue = COALESCE(@ReturnValue + ', '''' as ''' + FriendlyName + '''', ''''''''' as ''' + FriendlyName + '''')
 from autofillschemadataviewcolumns 
where fkAutofillSchemaDataView = @pkAutofillSchemaDataView 
and Visible = 1

order by SortOrder

set @ReturnValue = 'select ' +  substring(@ReturnValue,3,len(@ReturnValue)-3) + ''' where 1 = 2'
set @ReturnValue = REPLACE(@ReturnValue,'[','')
set @ReturnValue = REPLACE(@ReturnValue,']','')

return @ReturnValue
END
