create proc [dbo].[CPImportBatchStepInsert]
	@fkCPImportBatch decimal
	,@StepDescription varchar(1000)
	,@StepDate datetime = null
as

set @StepDate = ISNULL(@StepDate,getdate())

insert CPImportBatchStep
	(
		fkCPImportBatch
		,StepDate
		,StepDescription
	)
values
	(
		@fkCPImportBatch
		,@StepDate
		,@StepDescription
	)
	