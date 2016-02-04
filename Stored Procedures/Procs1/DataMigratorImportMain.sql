
/*

exec DataMigratorImportMain @PreserveLastXImportSets = 3

--dmdev_startover
--dmdev_reloadstaging

update DataMigratorStaging
set	fkCPClient = null
	,fkcpclientcase = null
	,fkCPImportBatch  = -1
	,fkCPClientAddressMailing = null
	,fkCPClientAddressPhysical = null
	,fkProgramType = null
	,SubBatchID = -1
	,ExclusionFlag = 0
	,CaseHeadUniqueID = null
	
update DataMigratorStaging
set CaseHead = b.CaseHead
from DataMigratorStaging s
join DataMigratorStaging4 b
	on s.pkDataMigratorStaging = b.pkDataMigratorStaging

	

exec [DataMigratorImportMain] @SubBatchSize =  0

exec dmdev_ReconcileAuditCounts

--select count(*) from cpjoinclientclientcase -- 57772


select fkcpclient, fkcpclientcase, count(*)
from cpjoinclientclientcase
group by fkcpclient, fkcpclientcase
having count(*) > 1

select fkcpimportbatch, count(*)
from datamigratorstaging
group by fkcpimportbatch


*/

CREATE proc [dbo].[DataMigratorImportMain]
	@DelaySecondsBetweenBatches int = 0
	,@SubBatchSize int = 1000
	,@PreserveLastXImportSets int = 3
	
as

declare @fkCPImportBatchV4 decimal
		,@fkCPImportBatchStepV4 decimal
		,@TargetSubBatchID int
		,@TargetSubBatchIDString varchar(50)
		,@LastSubBatchID int
		,@LastSubBatchString varchar(50)
		,@RecordCount int
		,@StepDescription varchar(1000)
		,@DelayTime varchar(8)		

set @DelayTime = '00:00:00'
if @DelaySecondsBetweenBatches > 0 BEGIN
	set @DelayTime = right('0' + rtrim(convert(char(2), @DelaySecondsBetweenBatches / (60 * 60))), 2) + ':' + 
	right('0' + rtrim(convert(char(2), (@DelaySecondsBetweenBatches / 60) % 60)), 2) + ':' + 
	right('0' + rtrim(convert(char(2), @DelaySecondsBetweenBatches % 60)),2)
END
		
insert	CPImportBatchV4
	(
		CreateUser
		,CreateDate
	)
select suser_name()
		,getdate()

set @fkCPImportBatchV4 = scope_identity()
set @TargetSubBatchID = 1
set @LastSubBatchID = 1

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Delete old staging records'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

if @PreserveLastXImportSets > 0 BEGIN
	delete DataMigratorStaging
	where fkCPImportBatch <> -1
	and fkCPImportBatch not in 
		(
			select top (@PreserveLastXImportSets) pkCPImportBatchV4
			from CPImportBatchV4
			order by pkCPImportBatchV4 desc
		)
END

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Rebuild staging table indexes'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

ALTER INDEX [PK_DataMigratorStaging] ON [dbo].[DataMigratorStaging] REBUILD  WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
ALTER INDEX [fkCPImportBatch_ProgramTypeName] ON [dbo].[DataMigratorStaging] REBUILD  WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
ALTER INDEX [fkCPImportBatch_SubBatchID] ON [dbo].[DataMigratorStaging] REBUILD  WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
ALTER INDEX [fkCPImportBatch_fkCPClient_ExclusionFlag] ON [dbo].[DataMigratorStaging] REBUILD  WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
ALTER INDEX [fkCPImportBatch_ClientUniqueID] ON [dbo].[DataMigratorStaging] REBUILD WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Set batch ID'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging 
set fkCPImportBatch = @fkCPImportBatchV4
where fkCPImportBatch = -1

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4
		
select @RecordCount = COUNT(*) 
from DataMigratorStaging 
where fkCPImportBatch = @fkCPImportBatchV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Perform Staging Table PreProcess'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
				
exec DataMigratorStagingPreProcess
	@fkCPImportBatchV4 = @fkCPImportBatchV4
	,@SubBatchSize = @SubBatchSize
	,@MaxSubBatchID = @LastSubBatchID OUTPUT
	
set @LastSubBatchString = rtrim(CAST(@LastSubBatchID as varchar(50)))

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

/*******Stop here for development********/
		
while (@TargetSubBatchID <= @LastSubBatchID) BEGIN
		set @TargetSubBatchIDString = rtrim(CAST(@TargetSubBatchID as varchar(50)))
		set @StepDescription  = 'Processing clients for sub-batch ' + @TargetSubBatchIDString + ' of ' + @LastSubBatchString
		
		exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = @StepDescription
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

			exec DataMigratorProcessClientsSubBatch
				@fkCPImportBatch = 	@fkCPImportBatchV4
				,@SubBatchID = @TargetSubBatchID

		exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4
		
		set @StepDescription  = 'Processing client custom attributes for sub-batch ' + @TargetSubBatchIDString + ' of ' + @LastSubBatchString
		exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = @StepDescription
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

			exec DataMigratorProcessClientCustomAttributesSubBatch
				@fkCPImportBatch = 	@fkCPImportBatchV4
				,@SubBatchID = @TargetSubBatchID

		exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4
		
		set @StepDescription  = 'Processing cases for sub-batch ' + @TargetSubBatchIDString + ' of ' + @LastSubBatchString
		exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = @StepDescription
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output


			exec DataMigratorProcessCasesSubBatch	
				@fkCPImportBatch = 	@fkCPImportBatchV4
				,@SubBatchID = @TargetSubBatchID

		exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

		set @StepDescription  = 'Processing addresses for sub-batch ' + @TargetSubBatchIDString + ' of ' + @LastSubBatchString
		exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = @StepDescription
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

			exec DataMigratorProcessAddressesSubBatch
				@fkCPImportBatch = 	@fkCPImportBatchV4
				,@SubBatchID = @TargetSubBatchID

		exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

		set @TargetSubBatchID = @TargetSubBatchID + 1
		
		if @DelaySecondsBetweenBatches > 0 BEGIN
			waitfor delay @DelayTime
		END
		
		
	END

/*************
This must be the last step
*************/
update CPImportBatchV4
set		ImportEnd = getdate()
		,RecordCount = @RecordCount 
where	pkCPImportBatchV4 = @fkCPImportBatchV4










