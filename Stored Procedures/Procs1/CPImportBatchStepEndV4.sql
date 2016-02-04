CREATE proc [dbo].[CPImportBatchStepEndV4]
	@pkCPImportBatchStepV4 decimal
as

update	CPImportBatchStepV4
set		EndDate = getdate()
where pkCPImportBatchStepV4 = @pkCPImportBatchStepV4