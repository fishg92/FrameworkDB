
CREATE proc [dbo].[DataMigratorStagingPreProcess]
	@fkCPImportBatchV4 decimal
	,@SubBatchSize int = 1000
	,@MaxSubBatchID int = null output
as

/****************************
Current V3 code:

uspCPImportFromStaging
CPImportStaging

**************************/
--First, trim all fields
--and reduce size to the max allowed size in
--the corresponding People tables



declare @CheckSumForBlankAddress int
		,@fkCPImportBatchStepV4 decimal
set @CheckSumForBlankAddress = checksum('','','','','','','')


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign program types'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update	DataMigratorStaging
set		fkProgramType  = pt.pkProgramType
from	DataMigratorStaging s
join ProgramType pt
	on s.ProgramTypeName = pt.ProgramType
where fkCPImportBatch = @fkCPImportBatchV4


exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Trim field values'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update	DataMigratorStaging
set		ClientUniqueID = rtrim(left(ltrim(ClientUniqueID),50))
		,FirstName = rtrim(left(ltrim(FirstName),100))
		,LastName = rtrim(left(ltrim(LastName),100))
		,MiddleName = rtrim(left(ltrim(MiddleName),100))
		,Suffix = LTRIM(RTRIM(Suffix))
		,MaidenName = rtrim(left(ltrim(MaidenName),100))
		,SSN = rtrim(left(ltrim(SSN),9))
		,Sex = rtrim(left(ltrim(Sex),1))
		,BirthLocation = rtrim(left(ltrim(BirthLocation),100))
		,SchoolName = rtrim(left(ltrim(SchoolName),100))
		,Education = rtrim(left(ltrim(Education),255))
		,StateCaseNumber = rtrim(left(ltrim(StateCaseNumber),20))
		,LocalCaseNumber = rtrim(left(ltrim(LocalCaseNumber),20))
		,MailingAddressStreet1 = rtrim(left(ltrim(MailingAddressStreet1),100))
		,MailingAddressStreet2 = rtrim(left(ltrim(MailingAddressStreet2),100))
		,MailingAddressStreet3 = rtrim(left(ltrim(MailingAddressStreet3),100))
		,MailingAddressCity = rtrim(left(ltrim(MailingAddressCity),100))
		,MailingAddressState = rtrim(left(ltrim(MailingAddressState),50))
		,MailingAddressZip = rtrim(left(replace(replace(ltrim(MailingAddressZip),' ',''),'-',''),5))
		,MailingAddressZipPlus4 = substring(replace(replace(ltrim(rtrim(MailingAddressZipPlus4)),' ',''),'-',''),1,4)
		,PhysicalAddressStreet1 = rtrim(left(ltrim(PhysicalAddressStreet1),100))
		,PhysicalAddressStreet2 = rtrim(left(ltrim(PhysicalAddressStreet2),100))
		,PhysicalAddressStreet3 = rtrim(left(ltrim(PhysicalAddressStreet3),100))
		,PhysicalAddressCity = rtrim(left(ltrim(PhysicalAddressCity),100))
		,PhysicalAddressState = rtrim(left(ltrim(PhysicalAddressState),50))
		,PhysicalAddressZip = left(replace(replace(ltrim(PhysicalAddressZip),' ',''),'-',''),5)
		,PhysicalAddressZipPlus4 = substring(replace(replace(ltrim(rtrim(PhysicalAddressZipPlus4)),' ',''),'-',''),1,4)
		,HomePhoneNumber = rtrim(left(replace(replace(replace(replace(replace(ltrim(HomePhoneNumber),'-',''),' ',''),'(',''),')',''),'.',''),10))
		,CellPhoneNumber = left(replace(replace(replace(replace(replace(ltrim(rtrim(CellPhoneNumber)),'-',''),' ',''),'(',''),')',''),'.',''),10)
		,SubBatchID = -1
		,Data1 = ltrim(rtrim(Data1))
		,Data2 = ltrim(rtrim(Data2))
		,Data3 = ltrim(rtrim(Data3))
		,Data4 = ltrim(rtrim(Data4))
		,Data5 = ltrim(rtrim(Data5))
		,Data6 = ltrim(rtrim(Data6))
		,Data7 = ltrim(rtrim(Data7))
		,Data8 = ltrim(rtrim(Data8))
		,Data9 = ltrim(rtrim(Data9))
		,Data10 = ltrim(rtrim(Data10))
		,Data11 = ltrim(rtrim(Data11))
		,Data12 = ltrim(rtrim(Data12))
		,Data13 = ltrim(rtrim(Data13))
		,Data14 = ltrim(rtrim(Data14))
		,Data15 = ltrim(rtrim(Data15))
		,Data16 = ltrim(rtrim(Data16))
		,Data17 = ltrim(rtrim(Data17))
		,Data18 = ltrim(rtrim(Data18))
		,Data19 = ltrim(rtrim(Data19))
		,Data20 = ltrim(rtrim(Data20))
		,Data21 = ltrim(rtrim(Data21))
		,Data22 = ltrim(rtrim(Data22))
		,Data23 = ltrim(rtrim(Data23))
		,Data24 = ltrim(rtrim(Data24))
		,Data25 = ltrim(rtrim(Data25))
		,Data26 = ltrim(rtrim(Data26))
		,Data27 = ltrim(rtrim(Data27))
		,Data28 = ltrim(rtrim(Data28))
		,Data29 = ltrim(rtrim(Data29))
		,Data30 = ltrim(rtrim(Data30))
		,Data31 = ltrim(rtrim(Data31))
		,Data32 = ltrim(rtrim(Data32))
		,Data33 = ltrim(rtrim(Data33))
		,Data34 = ltrim(rtrim(Data34))
		,Data35 = ltrim(rtrim(Data35))
		,Data36 = ltrim(rtrim(Data36))
		,Data37 = ltrim(rtrim(Data37))
		,Data38 = ltrim(rtrim(Data38))
		,Data39 = ltrim(rtrim(Data39))
		,Data40 = ltrim(rtrim(Data40))
		,Email = ltrim(rtrim(Email))
where fkCPImportBatch = @fkCPImportBatchV4

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Set exclusion flag'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output


--skip any rows that don't have a matching program type
-- or the birthdate is invalid...but not null
--note, this logic is verbatim from previous DM
UPDATE DataMigratorStaging 
SET ExclusionFlag = 1
where fkCPImportBatch = @fkCPImportBatchV4
and (fkProgramType = 0 
or fkProgramType is null
OR BirthDate is null
or Birthdate < dateadd(year,-150,getdate())
or BirthDate > getdate()
or ClientUniqueID = '')

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Set mailing address score'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output


update DataMigratorStaging
set		MailingAddressScore = 
	case when MailingAddressStreet1 <> '' then 1 else 0	end
	+ 	case when MailingAddressStreet2 <> '' then 1 else 0	end
	+ 	case when MailingAddressStreet3 <> '' then 1 else 0	end
	+ 	case when MailingAddressCity <> '' then 1 else 0	end
	+ 	case when MailingAddressState <> '' then 1 else 0	end
	+ 	case when MailingAddressZip <> '' then 1 else 0	end
	+ 	case when MailingAddressZipPlus4 <> '' then 1 else 0	end
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Set physical address score'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging
set		PhysicalAddressScore = 
	case when PhysicalAddressStreet1 <> '' then 1 else 0	end
	+ 	case when PhysicalAddressStreet2 <> '' then 1 else 0	end
	+ 	case when PhysicalAddressStreet3 <> '' then 1 else 0	end
	+ 	case when PhysicalAddressCity <> '' then 1 else 0	end
	+ 	case when PhysicalAddressState <> '' then 1 else 0	end
	+ 	case when PhysicalAddressZip <> '' then 1 else 0	end
	+ 	case when PhysicalAddressZipPlus4 <> '' then 1 else 0	end
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Clean up home phone numbers'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging
set HomePhoneNumber = x.HomePhoneNumber
from DataMigratorStaging s
join (select ClientUniqueID
			,HomePhoneNumber = max(HomePhoneNumber)
	from DataMigratorStaging
	where ClientUniqueID <> ''
	and fkCPImportBatch = @fkCPImportBatchV4
	and ExclusionFlag=0
	group by ClientUniqueID)x
	on s.ClientUniqueID = x.ClientUniqueID
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Clean up cell phone numbers'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
	
update DataMigratorStaging
set CellPhoneNumber = x.CellPhoneNumber
from DataMigratorStaging s
join (select ClientUniqueID
			,CellPhoneNumber = max(CellPhoneNumber)
	from DataMigratorStaging
	where ClientUniqueID <> ''
	and fkCPImportBatch = @fkCPImportBatchV4
	and ExclusionFlag = 0
	group by ClientUniqueID)x
	on s.ClientUniqueID = x.ClientUniqueID
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Clean up email'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
	
update DataMigratorStaging
set Email = ''
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and Email not like '%_@_%_.__%'

update DataMigratorStaging
set Email = x.Email
from DataMigratorStaging s
join (select ClientUniqueID
			,Email = max(Email)
	from DataMigratorStaging
	where ClientUniqueID <> ''
	and fkCPImportBatch = @fkCPImportBatchV4
	and ExclusionFlag = 0
	group by ClientUniqueID)x
	on s.ClientUniqueID = x.ClientUniqueID
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

/*
PCR 18055 - Removed this because local case number is being
used as a sub-case identifier in CPS cases

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Clean up local case numbers'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging
set LocalCaseNumber = x.LocalCaseNumber
from DataMigratorStaging s
join (select StateCaseNumber
			,LocalCaseNumber = max(LocalCaseNumber)
	from DataMigratorStaging
	where StateCaseNumber <> ''
	and fkCPImportBatch = @fkCPImportBatchV4
	and ExclusionFlag=0
	group by StateCaseNumber)x
	on s.StateCaseNumber = x.StateCaseNumber
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4
*/

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Clean up sex'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
	
update DataMigratorStaging
set Sex = x.Sex
from DataMigratorStaging s
join (select ClientUniqueID
			,Sex = max(Sex)
	from DataMigratorStaging
	where ClientUniqueID <> ''
	and fkCPImportBatch = @fkCPImportBatchV4
	and ExclusionFlag = 0
	group by ClientUniqueID)x
	on s.ClientUniqueID = x.ClientUniqueID
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
	
exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Remove duplicate case head values'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging 
	set CaseHead = 0 
	from DataMigratorStaging s
	join 	(
		select StateCaseNumber
				,ProgramTypeName
				,LocalCaseNumber
		from	DataMigratorStaging
		where fkCPImportBatch = @fkCPImportBatchV4
		and ExclusionFlag = 0
		and CaseHead  = 1
		group by StateCaseNumber
				,ProgramTypeName
				,LocalCaseNumber
		having count(*) > 1
	) l
	on s.StateCaseNumber = l.StateCaseNumber
		and s.ProgramTypeName = l.ProgramTypeName
		and s.LocalCaseNumber = l.LocalCaseNumber
where	dbo.IsCaseHeadAssignmentDeletable (s.StateCaseNumber,s.ClientUniqueID,s.BirthDate,s.pkDataMigratorStaging,s.fkCPImportBatch, s.ProgramTypeName, s.LocalCaseNumber) = 1
and fkCPImportBatch = @fkCPImportBatchV4
and CaseHead = 1
and ExclusionFlag = 0
		
exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Resolve inconsistent mailing addresses'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update	DataMigratorStaging
set	MailingAddressStreet1 = ''
	,MailingAddressStreet2 = ''
	,MailingAddressStreet3 = ''
	,MailingAddressCity = ''
	,MailingAddressState = ''
	,MailingAddressZip = ''
	,MailingAddressZipPlus4 = ''
	--,MailingAddressChecksum = @ChecksumForBlankAddress
from DataMigratorStaging s
join (	select	ClientUniqueID
		from	DataMigratorStaging
		where fkCPImportBatch = @fkCPImportBatchV4
		and	ExclusionFlag = 0
		group by ClientUniqueID
		having count(*) > 1) x
	on s.ClientUniqueID = x.ClientUniqueID
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and MailingAddressChecksum <> @ChecksumForBlankAddress
and dbo.IsBestMailingAddress
	(
		s.pkDataMigratorStaging
		,s.ClientUniqueID
		,s.MailingAddressScore
		,s.MailingAddressChecksum
		,@fkCPImportBatchV4
	) = 0


exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4


exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Resolve inconsistent physical addresses'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update	DataMigratorStaging
set	PhysicalAddressStreet1 = ''
	,PhysicalAddressStreet2 = ''
	,PhysicalAddressStreet3 = ''
	,PhysicalAddressCity = ''
	,PhysicalAddressState = ''
	,PhysicalAddressZip = ''
	,PhysicalAddressZipPlus4 = ''
	--,PhysicalAddressChecksum = @ChecksumForBlankAddress
from DataMigratorStaging s
join (	select	ClientUniqueID
		from	DataMigratorStaging
		where fkCPImportBatch = @fkCPImportBatchV4
		and	ExclusionFlag = 0
		group by ClientUniqueID
		having count(*) > 1) x
	on s.ClientUniqueID = x.ClientUniqueID
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and PhysicalAddressChecksum <> @ChecksumForBlankAddress
and dbo.IsBestPhysicalAddress
	(
		s.pkDataMigratorStaging
		,s.ClientUniqueID
		,s.PhysicalAddressScore
		,s.PhysicalAddressChecksum
		,@fkCPImportBatchV4
	) = 0

									
exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4



/** 
Update staging table with foreign keys to Pilot entities where possible
**/

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign sub batch IDs'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output


declare @SubBatchID int
set @SubBatchID = 1

while exists (select * from DataMigratorStaging
			where fkCPImportBatch = @fkCPImportBatchV4
			and SubBatchID = -1)
	begin
	
	if @SubBatchSize > 0 BEGIN
		set rowcount @SubBatchSize 	
	END
	
	update	DataMigratorStaging
	set SubBatchID = @SubBatchID
	where fkCPImportBatch = @fkCPImportBatchV4
	and SubBatchID = -1
	
	set @SubBatchID = @SubBatchID + 1
	end
	
set rowcount 0

set @MaxSubBatchID = @SubBatchID -1

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4



exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing client keys, match by unique number'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
  
--CPClient	
update DataMigratorStaging
set		fkCPClient = c.pkCPClient
from	DataMigratorStaging s
join CPClient c
	on s.ClientUniqueID = c.StateIssuedNumber
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and s.ClientUniqueID <> ''

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4



exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing client keys, match SSN'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging
set		fkCPClient = c.pkCPClient
from	DataMigratorStaging s
join CPClient c
	on s.SSN = c.SSN
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and s.SSN <> '000000000'
and s.SSN <> ''
and s.fkCPClient is null
and (s.ClientUniqueID = '' or c.StateIssuedNumber = '')

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4



exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing client keys, match name and DOB, Compass SSN blank'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output


update DataMigratorStaging
set		fkCPClient = c.pkCPClient
from	DataMigratorStaging s
join CPClient c
	on s.FirstName = c.FirstName
	and s.LastName = c.LastName
	and s.BirthDate = c.BirthDate
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and c.BirthDate <> '1/1/1900'
and (s.ClientUniqueID = '' or c.StateIssuedNumber = '')
and 
	(
		c.SSN = ''
		or
		c.SSN = '000000000'
	)
and s.SSN <> '000000000'	
and s.FirstName <> ''
and s.LastName <> ''
and s.fkCPClient is null

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4



exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing client keys, match name and DOB, import SSN =000000000'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output



update DataMigratorStaging
set		fkCPClient = c.pkCPClient
from	DataMigratorStaging s
join CPClient c
	on s.FirstName = c.FirstName
	and s.LastName = c.LastName
	and s.BirthDate = c.BirthDate
where fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and c.BirthDate <> '1/1/1900'
and (s.ClientUniqueID = '' or c.StateIssuedNumber = '')
and s.SSN = '000000000'
and s.FirstName <> ''
and s.LastName <> ''
and s.fkCPClient is null

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing education types'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
  

--CPClient Education Type
update	DataMigratorStaging
set	fkCPRefClientEducationType = r.pkCPRefClientEducationType
from	DataMigratorStaging s
join CPRefClientEducationType r
	on s.Education = isnull(r.Description,'')
where s.fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing case keys'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output
  

--CPClientCase
--This is done in 2 steps. The first matches on both state and local numbers
--if a local number is provided in the import
update	DataMigratorStaging
set		fkCPClientCase = cc.pkCpClientCase
from	DataMigratorStaging s
join CPClientCase cc
	on s.StateCaseNumber = cc.StateCaseNumber
	and s.LocalCaseNumber = cc.LocalCaseNumber
	and s.fkProgramType = cc.fkCPRefClientCaseProgramType
where s.fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and s.StateCaseNumber <> ''
and s.LocalCaseNumber <> ''

--Second step matches on only state case number if local
--is not provided in the import
update	DataMigratorStaging
set		fkCPClientCase = cc.pkCpClientCase
from	DataMigratorStaging s
join CPClientCase cc
	on s.StateCaseNumber = cc.StateCaseNumber
	and s.fkProgramType = cc.fkCPRefClientCaseProgramType
where s.fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and s.StateCaseNumber <> ''
and s.LocalCaseNumber = ''
and s.fkCPClientCase is null


exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign case worker IDs'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update  DataMigratorStaging
set		fkApplicationUserCaseWorker = au.pkApplicationUser
from	DataMigratorStaging s
left join  ApplicationUser AU 
	on dbo.RemoveLeadingZerosFromVarChar(AU.StateID) = dbo.RemoveLeadingZerosFromVarChar(s.CaseWorkerID)
	and isnull(AU.StateID, '')<>''
where s.fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0

update  DataMigratorStaging
set		fkApplicationUserCaseWorker = ca.fkApplicationUser
from	DataMigratorStaging s
left join cpCaseWorkerAltID ca
	on dbo.RemoveLeadingZerosFromVarChar(s.CaseWorkerID) = dbo.RemoveLeadingZerosFromVarChar(ca.WorkerId)
where s.fkCPImportBatch = @fkCPImportBatchV4
and ExclusionFlag = 0
and fkApplicationUserCaseWorker is null
	
exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing mailing address keys'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

--Mailing Address	

/* find the fk to any address matching the data and type */
update DataMigratorStaging
set fkCPClientAddressMailing = addr.pkCPClientAddress
from DataMigratorStaging s
join CPClientAddress addr
	on s.MailingAddressChecksum = addr.DataCheckSum
join CPJoinClientClientAddress j
	on addr.pkCPClientAddress = j.fkCPClientAddress
	and j.fkCPClient = s.fkCPClient
where addr.fkCPRefClientAddressType = 1
and s.MailingAddressChecksum <> @CheckSumForBlankAddress 
and s.fkCPImportBatch = @fkCPImportBatchV4
and s.ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec CPImportBatchStepInsertV4
		@fkCPImportBatchV4 = @fkCPImportBatchV4
		,@StepDescription = 'Assign existing physical address keys'
		,@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4 output

update DataMigratorStaging
set fkCPClientAddressPhysical = addr.pkCPClientAddress
from DataMigratorStaging s
join CPClientAddress addr
	on s.PhysicalAddressChecksum = addr.DataCheckSum 
join CPJoinClientClientAddress j
	on addr.pkCPClientAddress = j.fkCPClientAddress
	and j.fkCPClient = s.fkCPClient
where addr.fkCPRefClientAddressType = 2
and s.PhysicalAddressChecksum <> @CheckSumForBlankAddress 
and s.fkCPImportBatch = @fkCPImportBatchV4
and s.ExclusionFlag = 0

exec CPImportBatchStepEndV4
		@pkCPImportBatchStepV4 = @fkCPImportBatchStepV4

exec LogRejectedDataMigratorRows @fkCPImportBatchV4
