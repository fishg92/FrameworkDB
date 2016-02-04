
--exec LogRejectedDataMigratorRows '1' 

CREATE PROC [dbo].[LogRejectedDataMigratorRows]
	@fkCPImportBatch decimal (18,0)
AS

if OBJECT_ID(N'dbo.DataMigratorStagingRejectedRow','U') IS NOT NULL
	DROP TABLE DataMigratorStagingRejectedRow


Select 
  pkDataMigratorStaging
 ,ProgramTypeName
 ,ClientUniqueID
 ,BirthDate
 ,Reason =
	CASE 
		WHEN isnull(fkProgramType,0) = 0 THEN 'Invalid Program Type'
		When Birthdate < dateadd(year,-150,getdate()) THEN 'BirthDate is over 150 years ago'
		When BirthDate > getdate() THEN 'BirthDate is after today''s date'
		When ClientUniqueID = '' Then 'Client Unique ID is missing' 
	END
into dbo.DataMigratorStagingRejectedRow 
from DataMigratorStaging DM
where DM.ExclusionFlag = 1
and DM.fkCPImportBatch = @fkCPImportBatch
