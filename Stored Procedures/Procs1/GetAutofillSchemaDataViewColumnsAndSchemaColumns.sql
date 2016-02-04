-- =============================================
-- Author:		Jerrel Blankenship/James Neno
-- Create date: 7/28/2010
-- Description:	Gets the related AutofillSchemaDataViewColumns and their related AutofillSchemaColumns for a given AutofillSchemaDataView
-- =============================================
CREATE PROCEDURE [dbo].[GetAutofillSchemaDataViewColumnsAndSchemaColumns] 
	-- Add the parameters for the stored procedure here
	@pkAutofillSchemaDataView decimal = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT	*
	FROM	
		AutofillSchemaDataViewColumns
	WHERE 	
		(@pkAutofillSchemaDataView IS NULL OR fkAutofillSchemaDataView = @pkAutofillSchemaDataView)		
 
	select * 
	from 
		AutofillSchemaColumns 
	where 
		pkAutofillSchemaColumns in 
				(select 
					fkAutofillSchemaColumns 
				from 
					AutofillSchemaDataViewColumns 
				where 
					(@pkAutofillSchemaDataView IS NULL OR fkAutofillSchemaDataView = @pkAutofillSchemaDataView))				
END
