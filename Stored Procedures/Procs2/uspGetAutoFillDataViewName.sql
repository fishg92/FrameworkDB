
-- [dbo].[uspGetAutoFillDataViewName] 1

CREATE  PROC [dbo].[uspGetAutoFillDataViewName]
(
	@DataViewID int
)
AS

select FriendlyName as tSQL from autofillschemadataview where pkAutofillSchemaDataView = @DataViewID
