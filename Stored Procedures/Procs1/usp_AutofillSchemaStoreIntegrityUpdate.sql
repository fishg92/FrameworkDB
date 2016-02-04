
/*
EXEC usp_AutofillSchemaStoreIntegrityUpdate
*/

CREATE PROC [dbo].[usp_AutofillSchemaStoreIntegrityUpdate]
AS

if not exists (select * from autofillschemadatastore
	where fkrefAutofillSchemaDataSourceType = 1)
BEGIN
	insert into autofillschemadatastore (FriendlyName, fkrefAutofillSchemaDataSourceType)
		values ('Compass Pilot Database', 1)

	declare @pkautofillschemadatastore decimal
END

	select top 1 @pkautofillschemadatastore = pkautofillschemadatastore
	from autofillschemadatastore
	where fkrefAutofillSchemaDataSourceType = 1
	update AutofillSchema set fkAutofillSchemaDataStore = @pkautofillschemadatastore
		where fkAutofillSchemaDataStore is null 
			or fkAutofillSchemaDataStore not in (select pkautofillschemadatastore
				from autofillschemadatastore)	


SET ANSI_NULLS OFF
