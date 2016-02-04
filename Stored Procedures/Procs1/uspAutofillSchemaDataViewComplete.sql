-- =============================================
-- Author:		Jerrel Blankenship
-- Create date: 08/13/2010
-- Description:	Returns the complete data needed for a dataView object for the given dataView ID
-- =============================================
CREATE PROCEDURE [dbo].[uspAutofillSchemaDataViewComplete] 
(	
	@pkAutofillSchemaDataView decimal = 0
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @pkAutofillSchema decimal
	
    -- Insert statements for procedure here
    select 
		@pkAutofillSchema = fkAutofillSchema		
	from 
		autofillschemadataview 
	where 
		pkAutofillSchemaDataView = @pkAutofillSchemaDataView
		
	select 
		pkAutofillSchemaDataView,
		fkAutofillSchema,
		FriendlyName,
		IgnoreProgramTypeSecurity,
		IgnoreSecuredClientSecurity
	from 
		autofillschemadataview 
	where 
		pkAutofillSchemaDataView = @pkAutofillSchemaDataView
	
	select 
		* 
	from 
		autofillschemadataviewcolumns 
	where 
		fkAutofillSchemaDataView = @pkAutofillSchemaDataView
	
	select 
		* 
	from 
		autofillschema 
	where 
		pkAutofillSchema = @pkAutofillSchema
		
	select 
		* 
	from 
		autofillschemacolumns 
	where 
		fkAutofillschema = @pkAutofillSchema
END
