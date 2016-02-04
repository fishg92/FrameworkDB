
-- select dbo.[fnGetAutoFillSchemaColumnKeyByName] ('ItemKey',971)
CREATE FUNCTION [dbo].[fnGetAutoFillSchemaColumnKeyByName]
(
	@FieldName varchar(255)
	,@fkAutoFillSchema decimal
) 
RETURNS decimal
AS
BEGIN
	DECLARE @Ret decimal
	set @Ret = -1
	select @Ret = pkAutofillSchemaColumns from  dbo.AutoFillSchemaColumns
		where FieldName = rtrim(@FieldName)
		and fkAutofillSchema = @fkAutoFillSchema
	
	RETURN @Ret
END
