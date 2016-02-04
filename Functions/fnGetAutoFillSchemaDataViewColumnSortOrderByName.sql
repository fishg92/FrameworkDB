
--select * from AutoFillSchemaDataViewColumns
-- select dbo.[fnGetAutoFillSchemaDataViewColumnSortOrderByName] ('Grouping','8/3/2010 8:00 AM',13920)
CREATE FUNCTION [dbo].[fnGetAutoFillSchemaDataViewColumnSortOrderByName]
(
	@FieldName varchar(255)
	,@TargetDate datetime
	,@fkAutofillSchemaDataview decimal
) 
RETURNS integer
AS
BEGIN
	DECLARE @Ret integer
	set @Ret = 0
	select top 1 @Ret = SortOrder from  dbo.AutoFillSchemaDataViewColumnsAudit v
		inner join AutofillSchemaColumnsAudit c 
			on v.fkAutoFillSchemaColumns = c.pkAutoFillSchemaColumns
			and c.FieldName = rtrim(@FieldName)
			and @TargetDate between c.AuditStartDate and isnull(c.AuditEndDate,getdate())
		where @TargetDate between  v.AuditStartDate and isnull(v.AuditEndDate, getdate())
		and v.fkAutofillSchemaDataview = @fkAutofillSchemaDataview
order by pkAutofillSchemaDataViewColumns desc

	
	RETURN @Ret
END
