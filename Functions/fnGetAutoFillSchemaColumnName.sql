
--select * from  dbo.AutoFillSchemaColumnsAuditEff order by pkAutofillSchemaColumns
-- select dbo.[fnGetAutoFillSchemaColumnName] (793, '7/3/2010 11:00 AM')
CREATE FUNCTION [dbo].[fnGetAutoFillSchemaColumnName]
(
	@pkAutofillSchemaColumns decimal
	,@TargetDate datetime
) 
RETURNS varchar(255)
AS
BEGIN
	DECLARE @Ret varchar(255)
	set @Ret = ''
	select top 1 @Ret = Fieldname from  dbo.AutoFillSchemaColumns
		where 
/*
@TargetDate between AuditEffStartDate and isnull(AuditEffEndDate,getdate())
		and 
*/
pkAutofillSchemaColumns = @pkAutofillSchemaColumns
	
	RETURN @Ret
END
