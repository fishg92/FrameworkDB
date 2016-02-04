



--exec spCPGetRelatedClientDataFromPKClient '1'
CREATE    Proc [dbo].[usp_CPGetAutofillDataFromPKClient]
(		
		@pkCPClient Decimal(18,0) 
)

as

If exists (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CompassClientInformation' AND COLUMN_NAME = 'Compass Number')

Begin
	select *
	from CompassClientInformation
	where pkCPClient = @pkCPClient
End


