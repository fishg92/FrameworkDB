






CREATE FUNCTION [dbo].[IsCaseHeadAssignmentDeletable] (
   @StateCaseNumber  varchar(20)
  ,@ClientUniqueID varchar(50)
  ,@BirthDate datetime
  ,@pkDataMigratorStaging decimal(18,0)
  ,@fkCPImportBatch decimal(18,0)
  ,@ProgramTypeName varchar(50)
  ,@LocalCaseNumber varchar(20)
)

RETURNS   tinyint AS  
BEGIN 

declare @IsDeletable bit
set @IsDeletable = 0

if exists (select * from DataMigratorStaging s
	where s.CaseHead = 1 
		and s.StateCaseNumber = @StateCaseNumber
		and s.LocalCaseNumber = @LocalCaseNumber
		and s.ProgramTypeName = @ProgramTypeName 
		and s.pkDataMigratorStaging <> @pkDataMigratorStaging
		and s.BirthDate >= @BirthDate
		and s.fkCPImportBatch = @fkCPImportBatch
		and s.ExclusionFlag = 0
		)
		BEGIN
			set @IsDeletable = 1
		END
		

return  @IsDeletable

END
