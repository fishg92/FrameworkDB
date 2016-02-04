CREATE proc [dbo].[CPImportBatchStepInsertV4]
	@fkCPImportBatchV4 decimal
	,@StepDescription varchar(1000)
	,@StepDate datetime = null
	,@pkCPImportBatchStepV4 decimal = null output
as

set @StepDate = ISNULL(@StepDate,getdate())

insert CPImportBatchStepV4
	(
		fkCPImportBatchV4
		,StepDate
		,StepDescription
	)
values
	(
		@fkCPImportBatchV4
		,@StepDate
		,@StepDescription
	)
	
set @pkCPImportBatchStepV4 = scope_identity()
	