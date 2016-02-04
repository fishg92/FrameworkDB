
CREATE proc [dbo].[DataMigratorProcessClientsSubBatch]
	@fkCPImportBatch decimal
	,@SubBatchID int
as

update CPClient	
	set LastName = case when  s.LastName = '' then cpClient.LastName else s.LastName end
	,FirstName = case when  s.FirstName = '' then cpClient.FirstName else s.FirstName end
	,MiddleName = case when  s.MiddleName = '' then cpClient.MiddleName else s.MiddleName end
	,Suffix = case when  s.Suffix = '' then cpClient.Suffix else s.Suffix end
	,MaidenName = case when  s.MaidenName = '' then cpClient.MaidenName else s.MaidenName end
	,SSN = case when  s.SSN = '' then cpClient.SSN else s.SSN end
	,StateIssuedNumber = case when  s.ClientUniqueID = '' then cpClient.StateIssuedNumber else s.ClientUniqueID end
	,BirthDate = isnull(s.BirthDate,cpClient.BirthDate)
	,BirthLocation = case when  s.BirthLocation = '' then cpClient.BirthLocation else s.BirthLocation end
	,Sex = case when  s.Sex = '' then cpClient.Sex else s.Sex end
	,HomePhone = case when  s.HomePhoneNumber = '' then cpClient.HomePhone else s.HomePhoneNumber end
	,CellPhone = case when  s.CellPhoneNumber = '' then cpClient.CellPhone else s.CellPhoneNumber end
	,SchoolName = case when  s.SchoolName = '' then cpClient.SchoolName else s.SchoolName end
	,fkCPRefClientEducationType = ISNULL(s.fkCPRefClientEducationType,cpClient.fkCPRefClientEducationType)
	,Email = case when s.Email = '' then CPClient.Email else s.Email end
from DataMigratorStaging s
join CPClient on
 CPClient.pkCPClient = s.fkCPClient
and CPClient.DataCheckSum <> s.ClientChecksum
where s.ExclusionFlag = 0
and s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID

/* Need to force an update to education type in staging for staging records with 
	an invalid education type if they are cpclient records we just updated 
	so the check sums will match */
	/*
 update DataMigratorStaging 
	set fkCPRefClientEducationType =  c.fkCPRefClientEducationType
from cpClient c
join DataMigratorStaging on
 c.pkCPClient = fkCPClient
and c.DataCheckSum <> ClientChecksum
where ExclusionFlag = 0
and fkCPImportBatch = @fkCPImportBatch
and SubBatchID = @SubBatchID
and DataMigratorStaging.fkCPRefClientEducationType is null
*/

insert into CPClient
	(
		LastName
		,FirstName
		,MiddleName
		,Suffix
		,MaidenName
		,SSN
		,NorthwoodsNumber
		,StateIssuedNumber
		,BirthDate
		,BirthLocation
		,Sex
		,HomePhone
		,CellPhone
		,fkCPRefClientEducationType
		,SISNumber
		,SchoolName
		,Email
	)	
select distinct
	s.LastName
	,s.FirstName
	,s.MiddleName
	,s.Suffix
	,s.MaidenName
	,s.SSN
	,''
	,s.ClientUniqueID
	,s.BirthDate
	,s.BirthLocation
	,s.Sex
	,s.HomePhoneNumber
	,s.CellPhoneNumber
	,s.fkCPRefClientEducationType
	,''
	,s.SchoolName
	,s.Email
from DataMigratorStaging s
where s.ExclusionFlag = 0
and s.fkCPClient is null
and s.SubBatchID = @SubBatchID
and s.fkCPImportBatch = @fkCPImportBatch
and not exists (select	*
				from	CPClient
				where	DataChecksum = s.ClientChecksum)

/* Assign staging FKs for the records we just inserted above */
update	DataMigratorStaging 
set		fkCPClient = c.pkCPClient
from	DataMigratorStaging s
join CPClient c
	on c.DataChecksum = s.ClientChecksum
where fkCPImportBatch = @fkCPImportBatch
and ExclusionFlag = 0
and fkCPClient is null
and fkCPImportBatch = @fkCPImportBatch
and SubBatchID = @SubBatchID
