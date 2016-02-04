
CREATE PROCEDURE dbo.ImportDataFromSanMateoDataMigrator
	
AS
	
set nocount on

declare @BatchID decimal
select @BatchID = max(pkCPImportBatch) from dbo.CPImportBatch

--CalWorks
exec dbo.spCPImportProcessCalWorksV2 @BatchID

--CAPI
exec dbo.spCPImportProcessCAPIV2 @BatchID

--FoodStamps
exec dbo.spCPImportProcessFoodStampsV2 @BatchID

--GenAsst
exec dbo.spCPImportProcessGenAsstV2 @BatchID

--MediCal
exec dbo.spCPImportProcessMediCalV2 @BatchID

--Minor Consent
exec dbo.spCPImportProcessMinorConsentV2 @BatchID

--TANF
exec dbo.spCPImportProcessTANFV2 @BatchID


