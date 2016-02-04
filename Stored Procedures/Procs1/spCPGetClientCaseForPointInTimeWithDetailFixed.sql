
/*

exec [spCPGetClientCaseForPointInTimeWithDetailFixed]  5
*/

CREATE procedure [dbo].[spCPGetClientCaseForPointInTimeWithDetailFixed]
(
@pkCPClientCase decimal
)

as
set nocount on



declare @PrimaryClients table
(
	ClientpkCPClient decimal(18, 0)
	,ClientLastName varchar(100)
	,ClientFirstName varchar(100)
	,ClientMiddleName varchar(100)
	,ClientSSN char(10)
	,ClientNorthwoodsNumber varchar(50)
	,ClientStateIssuedNumber varchar(50)
	,ClientBirthDate datetime
	,ClientBirthLocation varchar(100)
	,ClientSex char(1)
	,ClientfkCPRefClientEducationType decimal(18,0)
	,ClientLockedUser varchar(50)
	,ClientLockedDate datetime
	,ClientMaidenName Varchar(100)
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
	,ClientSchoolName varchar(100)
	,ClientHomePhone varchar(10)
	,ClientCellPhone varchar(10)
	,ClientEmail varchar(250)

	,JoinpkCPJoinClientClientCase decimal(18, 0)
	,JoinfkCPClientCase decimal(18, 0)
	,JoinfkCPClient decimal(18, 0)
	,JoinPrimaryParticipantOnCase tinyint
	,JoinfkCPRefClientRelationshipType decimal(18,0)
	,JoinLockedUser varchar(50)
	,JoinLockedDate datetime

	,CasepkCPClientCase decimal(18, 0)
	,CaseStateCaseNumber varchar(20)
	,CaseLocalCaseNumber varchar(20)
	,CasefkCPRefClientCaseProgramType nvarchar(50)
	,CasefkCPCaseWorker decimal(18, 0)
	,CaseLockedUser varchar(50)
	,CaseLockedDate datetime
)

declare @t5 table
(
	ClientpkCPClient decimal(18, 0)
	,ClientLastName varchar(100)
	,ClientFirstName varchar(100)
	,ClientMiddleName varchar(100)
	,ClientSSN char(10)
	,ClientNorthwoodsNumber varchar(50)
	,ClientStateIssuedNumber varchar(50)
	,ClientBirthDate datetime
	,ClientBirthLocation varchar(100)
	,ClientSex char(1)
	,ClientfkCPRefClientEducationType decimal(18,0)
	,ClientLockedUser varchar(50)
	,ClientLockedDate datetime
	,ClientMaidenName Varchar(100)
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
	,ClientSchoolName varchar(100)
	,ClientHomePhone varchar(10)
	,ClientCellPhone varchar(10)
	,ClientEmail varchar(250)

	,JoinpkCPJoinClientClientCase decimal(18, 0)
	,JoinfkCPClientCase decimal(18, 0)
	,JoinfkCPClient decimal(18, 0)
	,JoinPrimaryParticipantOnCase tinyint
	,JoinfkCPRefClientRelationshipType decimal(18,0)
	,JoinLockedUser varchar(50)
	,JoinLockedDate datetime

	,CasepkCPClientCase decimal(18, 0)
	,CaseStateCaseNumber varchar(20)
	,CaseLocalCaseNumber varchar(20)
	,CasefkCPRefClientCaseProgramType nvarchar(50)
	,CasefkCPCaseWorker decimal(18, 0)
	,CaseLockedUser varchar(50)
	,CaseLockedDate datetime
)

declare @t table
(
	ClientpkCPClient decimal(18, 0)
	,ClientLastName varchar(100)
	,ClientFirstName varchar(100)
	,ClientMiddleName varchar(100)
	,ClientSSN char(10)
	,ClientNorthwoodsNumber varchar(50)
	,ClientStateIssuedNumber varchar(50)
	,ClientBirthDate datetime
	,ClientBirthLocation varchar(100)
	,ClientSex char(1)
	,ClientfkCPRefClientEducationType decimal(18,0)
	,ClientLockedUser varchar(50)
	,ClientLockedDate datetime
	,ClientMaidenName Varchar(100)
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
	,ClientSchoolName varchar(100)
	,ClientHomePhone varchar(10)
	,ClientCellPhone varchar(10)
	,ClientEmail varchar(250)

	,JoinpkCPJoinClientClientCase decimal(18, 0)
	,JoinfkCPClientCase decimal(18, 0)
	,JoinfkCPClient decimal(18, 0)
	,JoinPrimaryParticipantOnCase tinyint
	,JoinfkCPRefClientRelationshipType decimal(18,0)
	,JoinLockedUser varchar(50)
	,JoinLockedDate datetime

	,CasepkCPClientCase decimal(18, 0)
	,CaseStateCaseNumber varchar(20)
	,CaseLocalCaseNumber varchar(20)
	,CasefkCPRefClientCaseProgramType nvarchar(50)
	,CasefkCPCaseWorker decimal(18, 0)
	,CaseLockedUser varchar(50)
	,CaseLockedDate datetime

	,CaseNumberFilterpkCPClientCase decimal

	,JoinAddresspkCPJoinClientClientAddress decimal(18, 0)
	,JoinAddressCreateDate datetime
	,JoinAddressfkCPClient decimal(18, 0)
	,JoinAddressfkCPClientAddress decimal(18, 0)
	,JoinAddressLockedUser varchar(50)
	,JoinAddressLockedDate datetime

	,AddresspkCPClientAddress decimal(18, 0)
	,AddressfkCPRefClientAddressType decimal(18, 0)
	,AddressStreet1 varchar (100)
	,AddressStreet2 varchar (100)
	,AddressStreet3 varchar (100)
	,AddressCity varchar (100)
	,AddressState varchar (50)
	,AddressZip char (5)
	,AddressZipPlus4 char (4)
	,AddressLockedUser varchar(50)
	,AddressLockedDate datetime

	,JoinClientPhonepkCPJoinClientClientPhone decimal(18, 0)
	,JoinClientPhonefkCPClient decimal(18, 0)
	,JoinClientPhonefkCPClientPhone decimal(18, 0)
	,JoinClientPhoneLockedUser varchar(50)
	,JoinClientPhoneLockedDate datetime

	,ClientPhonepkCPClientPhone decimal(18, 0)
	,ClientPhonefkCPRefPhoneType decimal(18, 0)
	,ClientPhoneNumber varchar (10)
	,ClientPhoneExtension varchar (10)
	,ClientPhoneLockedUser varchar(50)
	,ClientPhoneLockedDate datetime

	,JoinClientAlertpkCPJoinClientAlertFlagTypeNT decimal(18, 0)
	,JoinClientAlertfkCPClient decimal(18, 0)
	,JoinClientAlertfkRefCPAlertFlagTypeNT decimal(18, 0)

	,RelationshippkCPJoinCPClientCPClientrefRelationship decimal
	,RelationshipfkCPClientParent decimal
	,RelationshipfkCPClientChild decimal
	,RelationshipfkParentCPrefClientRelationshipType decimal
	,RelationshipfkChildCPrefClientRelationshipType decimal
)

Declare @t2 Table
(
	ClientpkCPClient decimal(18,0)

	,JoinClientEmployerpkCPJoinClientEmployer decimal(18, 0)
	,JoinClientEmployerLUPDate datetime
	,JoinClientEmployerfkCPClient decimal(18, 0)
	,JoinClientEmployerfkCPEmployer decimal(18, 0)
	,JoinClientEmployerStartDate datetime
	,JoinClientEmployerEndDate datetime
	,JoinClientEmployerLockedUser varchar(50)
	,JoinClientEmployerLockedDate datetime

	,EmployerpkCPEmployer decimal(18, 0)
	,EmployerEmployerName varchar(255)
	,EmployerStreet1 varchar(100)
	,EmployerStreet2 varchar(100)
	,EmployerStreet3 varchar(100)
	,EmployerCity varchar(100)
	,EmployerState varchar(50)
	,EmployerZip char(5)
	,EmployerZipPlus4 char(4)
	,EmployerPhone varchar(10)
	,EmployerSalary varchar(50)

	,MilitarypkCPClientMilitaryRecord decimal(18, 0)
	,MilitaryfkCPClient decimal(18, 0)
	,MilitaryfkCPRefMilitaryBranch decimal(18, 0)
	,MilitaryStartDate datetime
	,MilitaryEndDate datetime
	,MilitaryDishonorablyDischarged bit
	,MilitaryLockedUser varchar(50)
	,MilitaryLockedDate datetime
	,MilitaryEventStart varchar(50)
	,MilitaryEventEnd varchar(50)

	,MarriageRecordpkCPClientMarriageRecord decimal(18, 0)
	,MarriageRecordfkCPClient decimal(18, 0)
	,MarriageRecordfkCPRefMarraigeEndType decimal(18, 0)
	,MarriageRecordStartDate datetime
	,MarriageRecordEndDate datetime
	,MarriageRecordLockedUser varchar(50)
	,MarriageRecordLockedDate datetime
	,MarriageRecordSpouse VARCHAR(50)
	,MarriageRecordEventDateFreeForm VARCHAR(50)
)

Declare @ClientNarrative table
(	
	ClientpkCPClient decimal(18,0)
)

/* need to get all cases based on intial search to find members of those cases */
Declare @ClientCaseFilter table
(	
	pkCPClientCase decimal 
)

		insert into @PrimaryClients
		select c.pkCPClient
			,c.LastName
			,c.FirstName
			,c.MiddleName
			,c.SSN
			,c.NorthwoodsNumber
			,c.StateIssuedNumber
			,c.BirthDate
			,c.BirthLocation
			,c.Sex
			,c.fkCPRefClientEducationType
			,c.LockedUser
			,c.LockedDate
			,c.MaidenName
			,c.Suffix
			,c.SISNumber
			,c.SchoolName
			,c.HomePhone
			,c.CellPhone
			,c.Email

			,j.pkCPJoinClientClientCase
			,j.fkCPClientCase
			,j.fkCPClient
			,j.PrimaryParticipantOnCase
			,j.fkCPRefClientRelationshipType
			,j.LockedUser
			,j.LockedDate

			,cc.pkCPClientCase
			,cc.StateCaseNumber
			,cc.LocalCaseNumber
			,cc.fkCPRefClientCaseProgramType
			,cc.fkCPCaseWorker
			,cc.LockedUser
			,cc.LockedDate
		From 	CPClient c with (NoLock)
		left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
		left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
		where 
			cc.pkCpClientCase = @pkCpCLientCase


		insert into @t5
		select * from @PrimaryClients

		union

		select c.pkCPClient
			,c.LastName
			,c.FirstName
			,c.MiddleName
			,c.SSN
			,c.NorthwoodsNumber
			,c.StateIssuedNumber
			,c.BirthDate
			,c.BirthLocation
			,c.Sex
			,c.fkCPRefClientEducationType
			,c.LockedUser
			,c.LockedDate
			,c.MaidenName
			,c.Suffix
			,c.SISNumber
			,c.SchoolName
			,c.HomePhone
			,c.CellPhone
			,c.Email

			,j.pkCPJoinClientClientCase
			,j.fkCPClientCase
			,j.fkCPClient
			,j.PrimaryParticipantOnCase
			,j.fkCPRefClientRelationshipType
			,j.LockedUser
			,j.LockedDate

			,cc.pkCPClientCase
			,cc.StateCaseNumber
			,cc.LocalCaseNumber
			,cc.fkCPRefClientCaseProgramType
			,cc.fkCPCaseWorker
			,cc.LockedUser
			,cc.LockedDate
		From 	CPClient c with (NoLock)
		left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
		left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
		where c.pkCPClient in (select fkCPClientParent 
								from CPJoinCPClientCPClientrefRelationship cjcr (NoLock)
								join @PrimaryClients pc on pc.ClientpkCPClient = cjcr.fkCPClientChild)

		union

		select c.pkCPClient
			,c.LastName
			,c.FirstName
			,c.MiddleName
			,c.SSN
			,c.NorthwoodsNumber
			,c.StateIssuedNumber
			,c.BirthDate
			,c.BirthLocation
			,c.Sex
			,c.fkCPRefClientEducationType
			,c.LockedUser
			,c.LockedDate
			,c.MaidenName
			,c.Suffix
			,c.SISNumber
			,c.SchoolName
			,c.HomePhone
			,c.CellPhone
			,c.Email

			,j.pkCPJoinClientClientCase
			,j.fkCPClientCase
			,j.fkCPClient
			,j.PrimaryParticipantOnCase
			,j.fkCPRefClientRelationshipType
			,j.LockedUser
			,j.LockedDate

			,cc.pkCPClientCase
			,cc.StateCaseNumber
			,cc.LocalCaseNumber
			,cc.fkCPRefClientCaseProgramType
			,cc.fkCPCaseWorker
			,cc.LockedUser
			,cc.LockedDate
		From 	CPClient c with (NoLock)
		left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
		left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
		where c.pkCPClient in (select fkCPClientChild
								from CPJoinCPClientCPClientrefRelationship cjcr (NoLock)
								join @PrimaryClients pc on pc.ClientpkCPClient = cjcr.fkCPClientParent)

		insert into @ClientCaseFilter
		select t5.CasepkCPClientCase 
		From @t5 t5
		where t5.CasepkCpClientcase = @pkCPClientCase 

		/* Broke all of the narrative out into a separate temporary table due to table size  */
		insert into @t
		select  t5.*
			,ccf.pkCPClientCase
	
			,ja.pkCPJoinClientClientAddress
			,ja.CreateDate
			,ja.fkCPClient
			,ja.fkCPClientAddress
			,ja.LockedUser
			,ja.LockedDate

			,ca.pkCPClientAddress
			,ca.fkCPRefClientAddressType
			,ca.Street1
			,ca.Street2
			,ca.Street3
			,ca.City
			,ca.State
			,ca.Zip
			,ca.ZipPlus4
			,ca.LockedUser
			,ca.LockedDate

			,jp.pkCPJoinClientClientPhone
			,jp.fkCPClient
			,jp.fkCPClientPhone
			,jp.LockedUser
			,jp.LockedDate

			,cp.pkCPClientPhone
			,isnull(jp.fkCPRefPhoneType,1)
			,cp.Number
			,cp.Extension
			,cp.LockedUser
			,cp.LockedDate
	
			,cja.pkCPJoinClientAlertFlagTypeNT
			,cja.fkCPClient
			,cja.fkRefCPAlertFlagTypeNT

			,cjcr.pkCPJoinCPClientCPClientrefRelationship
			,cjcr.fkCPClientParent
			,cjcr.fkCPClientChild
			,cjcr.fkParentCPrefClientRelationshipType
			,cjcr.fkChildCPrefClientRelationshipType
			
							 
		From @t5 t5
		Join @ClientCaseFilter ccf on ccf.pkCPClientCase = t5.CasepkCPClientCase 
		Left join CPJoinClientClientAddress ja with (NoLock) on ja.fkCPClient = t5.ClientpkCPClient
		Left join CPClientAddress ca with (NoLock) on ca.pkCPClientAddress = ja.fkCPClientAddress
		Left join CPJoinClientClientPhone jp with (NoLock) on jp.fkCPClient = t5.ClientpkCPClient
		Left join CPClientPhone cp with (NoLock) on cp.pkCPClientPhone = jp.fkCPClientPhone
		Left join CPJoinClientAlertFlagTypeNT cja with (NoLock) on cja.fkCPClient = t5.ClientpkCPClient
		Left Join CPJoinCPClientCPClientrefRelationship cjcr with (NoLock) on cjcr.fkCPClientParent = t5.ClientpkCPClient
	union
		select  t5.*
			,t5.CasepkCPClientCase
	
			,ja.pkCPJoinClientClientAddress
			,ja.CreateDate
			,ja.fkCPClient
			,ja.fkCPClientAddress
			,ja.LockedUser
			,ja.LockedDate

			,ca.pkCPClientAddress
			,ca.fkCPRefClientAddressType
			,ca.Street1
			,ca.Street2
			,ca.Street3
			,ca.City
			,ca.State
			,ca.Zip
			,ca.ZipPlus4
			,ca.LockedUser
			,ca.LockedDate

			,jp.pkCPJoinClientClientPhone
			,jp.fkCPClient
			,jp.fkCPClientPhone
			,jp.LockedUser
			,jp.LockedDate

			,cp.pkCPClientPhone
			,isnull(jp.fkCPRefPhoneType,1)
			,cp.Number
			,cp.Extension
			,cp.LockedUser
			,cp.LockedDate
	
			,cja.pkCPJoinClientAlertFlagTypeNT
			,cja.fkCPClient
			,cja.fkRefCPAlertFlagTypeNT

			,cjcr.pkCPJoinCPClientCPClientrefRelationship
			,cjcr.fkCPClientParent
			,cjcr.fkCPClientChild
			,cjcr.fkParentCPrefClientRelationshipType
			,cjcr.fkChildCPrefClientRelationshipType
							 
		From @t5 t5
		Left join CPJoinClientClientAddress ja with (NoLock) on ja.fkCPClient = t5.ClientpkCPClient
		Left join CPClientAddress ca with (NoLock) on ca.pkCPClientAddress = ja.fkCPClientAddress
		Left join CPJoinClientClientPhone jp with (NoLock) on jp.fkCPClient = t5.ClientpkCPClient
		Left join CPClientPhone cp with (NoLock) on cp.pkCPClientPhone = jp.fkCPClientPhone
		Left join CPJoinClientAlertFlagTypeNT cja with (NoLock) on cja.fkCPClient = t5.ClientpkCPClient
		Left Join CPJoinCPClientCPClientrefRelationship cjcr with (NoLock) on cjcr.fkCPClientParent = t5.ClientpkCPClient

		Insert Into @ClientNarrative
		Select c.pkCPClient
		From	(Select Distinct ClientpkCPClient as pkCPClient From @t) c
		join	CPCaseActivity ca (NoLock) on ca.fkCPClient = c.pkCPClient 

		Insert Into @t2
		Select	c.pkCPClient
			,ce.pkCPJoinClientEmployer
			,ce.LUPDate 
			,ce.fkCPClient
			,ce.fkCPEmployer
			,ce.StartDate
			,ce.EndDate
			,ce.LockedUser
			,ce.LockedDate

			,e.pkCPEmployer
			,e.EmployerName
			,e.Street1
			,e.Street2
			,e.Street3
			,e.City
			,e.State
			,e.Zip
			,e.ZipPlus4
			,e.Phone
			,e.Salary

			,cm.pkCPClientMilitaryRecord
			,cm.fkCPClient
			,cm.fkCPRefMilitaryBranch
			,cm.StartDate
			,cm.EndDate
			,cm.DishonorablyDischarged
			,cm.LockedUser
			,cm.LockedDate
			,cm.EventStart
			,cm.EventEnd

			,mr.pkCPClientMarriageRecord
			,mr.fkCPClient
			,mr.fkCPRefMarraigeEndType
			,mr.StartDate
			,mr.EndDate
			,mr.LockedUser
			,mr.LockedDate
			,mr.Spouse
			,mr.EventDateFreeForm
						 		
		From		(Select Distinct ClientpkCPClient as pkCPClient From @t) c
		Left Join 	CPJoinClientEmployer ce with (NoLock) on c.pkCPClient = ce.fkCPClient
		Left Join 	CPEmployer e with (NoLock) on ce.fkCPEmployer = e.pkCPEmployer
		Left Join 	CPClientMilitaryRecord cm with (NoLock) on c.pkCPClient = cm.fkCPClient
		Left Join	CPClientMarriageRecord mr with (NoLock) on c.pkCPClient = mr.fkCPClient

Select distinct	pkCPClient = ClientpkCPClient
		,LastName = case when upper(isnull(ClientLastName, '#EMPTY')) = '#EMPTY' then '' else ClientLastName end
		,FirstName = case when upper(isnull(ClientFirstName, '#EMPTY')) = '#EMPTY' then '' else ClientFirstName end
		,MiddleName = case when upper(isnull(ClientMiddleName, '#EMPTY')) = '#EMPTY' then '' else ClientMiddleName end
		,SSN = case when upper(isnull(ClientSSN, '#EMPTY')) = '#EMPTY' then '' else ClientSSN end
		,NorthwoodsNumber = case when upper(isnull(ClientNorthwoodsNumber, '#EMPTY')) = '#EMPTY' then '' else ClientNorthwoodsNumber end
		,StateIssuedNumber = case when upper(isnull(ClientStateIssuedNumber, '#EMPTY')) = '#EMPTY' then '' else ClientStateIssuedNumber end
		,BirthDate = ClientBirthDate
		,BirthLocation = ClientBirthLocation
		,Sex = case when upper(isnull(ClientSex, '#')) = '#' then '' else ClientSex end
		,fkCPRefClientEducationType = ClientfkCPRefClientEducationType
		,LockedUser = ClientLockedUser
		,LockedDate = ClientLockedDate
		,MaidenName = Isnull(ClientMaidenName, '')
		,Suffix = Isnull(ClientSuffix, '')
		,SISNumber = Isnull(ClientSISNumber, '')
		,SchoolName = Isnull(ClientSchoolName, '')
		,HomePhone = ClientHomePhone
		,CellPhone = ClientCellPhone
		,Email = ISNULL(ClientEmail, '')
from 	@t
Where	IsNull(ClientpkCPClient,0) <> 0

select distinct pkCPClientAddress = AddresspkCPClientAddress
		,fkCPRefClientAddressType = AddressfkCPRefClientAddressType
		,Street1 = isnull(AddressStreet1, '')
		,Street2 = isnull(AddressStreet2, '')
		,Street3 = isnull(AddressStreet3, '')
		,City = isnull(AddressCity, '')
		,State = isnull(AddressState, '')
		,Zip = isnull(AddressZip, '')
		,ZipPlus4 = ISNULL(AddressZipPlus4, '')		
		,LockedUser = AddressLockedUser
		,LockedDate = AddressLockedDate
from 	@t
Where	IsNull(AddresspkCPClientAddress,0) <> 0

select distinct	pkCPClientCase = CasepkCPClientCase
		,StateCaseNumber = case when upper(isnull(CaseStateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseStateCaseNumber end
		,LocalCaseNumber = case when upper(isnull(CaseLocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseLocalCaseNumber end
		,fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType
		,fkCPCaseWorker = CasefkCPCaseWorker
		,LockedUser = CaseLockedUser
		,LockedDate = CaseLockedDate
from 	@t
Where	IsNull(CasepkCPClientCase,0) <> 0

union 
select pkCPCLientCase
	,StateCaseNumber = case when upper(isnull(StateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else StateCaseNumber end
		,LocalCaseNumber = case when upper(isnull(LocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else LocalCaseNumber end
		,fkCPRefClientCaseProgramType 
		,fkCPCaseWorker 
		,LockedUser 
		,LockedDate 
from cpClientCase where pkCpClientCase = @pkCpClientCase

select distinct pkCPJoinClientClientAddress = JoinAddresspkCPJoinClientClientAddress
		,CreateDate = JoinAddressCreateDate
		,fkCPClient = JoinAddressfkCPClient
		,fkCPClientAddress = JoinAddressfkCPClientAddress
		,LockedUser = JoinAddressLockedUser
		,LockedDate = JoinAddressLockedDate
from 	@t
Where 	IsNull(JoinAddresspkCPJoinClientClientAddress,0) <> 0

Select distinct	pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
		,fkCPClientCase = JoinfkCPClientCase
		,fkCPClient = JoinfkCPClient
		,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase, 0)
		,fkCPRefClientRelationshipType = JoinfkCPRefClientRelationshipType
		,LockedUser = isnull(JoinLockedUser, '')
		,LockedDate = JoinLockedDate
from 	@t
Where	IsNull(JoinpkCPJoinClientClientCase,0) <> 0

select distinct pkCPJoinClientClientPhone = JoinClientPhonepkCPJoinClientClientPhone
		,fkCPClient = JoinClientPhonefkCPClient
		,fkCPClientPhone = JoinClientPhonefkCPClientPhone
from 	@t
Where	IsNull(JoinClientPhonepkCPJoinClientClientPhone,0) <> 0

select distinct pkCPClientPhone = ClientPhonepkCPClientPhone
		,fkCPRefPhoneType = ClientPhonefkCPRefPhoneType
		,Number = case when upper(isnull(ClientPhoneNumber, '#EMPTY')) = '#EMPTY' then '' else ClientPhoneNumber end
		,Extension = case when upper(isnull(ClientPhoneExtension, '#EMPTY')) = '#EMPTY' then '' else ClientPhoneExtension end
from 	@t
Where	IsNull(ClientPhonepkCPClientPhone,0) <> 0

select distinct	pkcpclient = ClientpkCPClient
From @ClientNarrative
where isnull(ClientpkCPClient, 0) <> 0

select distinct	pkCPJoinClientAlertFlagTypeNT = JoinClientAlertpkCPJoinClientAlertFlagTypeNT
		,fkCPClient = JoinClientAlertfkCPClient
		,fkRefCPAlertFlagTypeNT = JoinClientAlertfkRefCPAlertFlagTypeNT
From @t
where isnull(JoinClientAlertpkCPJoinClientAlertFlagTypeNT, 0) <> 0

Select Distinct	pkCPJoinClientEmployer = JoinClientEmployerpkCPJoinClientEmployer
		,LUPDate = JoinClientEmployerLUPDate
		,fkCPClient = JoinClientEmployerfkCPClient
		,fkCPEmployer = JoinClientEmployerfkCPEmployer
		,StartDate = JoinClientEmployerStartDate
		,EndDate = JoinClientEmployerEndDate
		,LockedUser = JoinClientEmployerLockedUser
		,LockedDate = JoinClientEmployerLockedDate
From @t2
Where IsNull(JoinClientEmployerpkCPJoinClientEmployer,0) <> 0

Select Distinct	pkCPEmployer = EmployerpkCPEmployer
		,EmployerName = EmployerEmployerName
		,Street1 = EmployerStreet1
		,Street2 = EmployerStreet2
		,Street3 = EmployerStreet3
		,City = EmployerCity
		,[State] = EmployerState
		,Zip = EmployerZip
		,ZipPlus4 = EmployerZipPlus4
		,Phone = EmployerPhone
		,Salary = EmployerSalary
From @t2
Where IsNull(EmployerpkCPEmployer,0) <> 0

Select Distinct	pkCPClientMilitaryRecord = MilitarypkCPClientMilitaryRecord
		,fkCPClient = MilitaryfkCPClient
		,fkCPRefMilitaryBranch = MilitaryfkCPRefMilitaryBranch
		,StartDate = MilitaryStartDate
		,EndDate = MilitaryEndDate
		,DishonorablyDischarged = MilitaryDishonorablyDischarged
		,LockedUser = MilitaryLockedUser
		,LockedDate = MilitaryLockedDate
		,EventStart = MilitaryEventStart
		,EventEnd = MilitaryEventEnd
From @t2
Where IsNull(MilitarypkCPClientMilitaryRecord,0) <> 0

Select Distinct	pkCPClientMarriageRecord = MarriageRecordpkCPClientMarriageRecord
		,fkCPClient = MarriageRecordfkCPClient
		,fkCPRefMarraigeEndType = MarriageRecordfkCPRefMarraigeEndType
		,StartDate = MarriageRecordStartDate
		,EndDate = MarriageRecordEndDate
		,LockedUser = MarriageRecordLockedUser
		,LockedDate = MarriageRecordLockedDate
		,Spouse = ISNULL(MarriageRecordSpouse, '')
		,EventDateFreeForm = isnull(MarriageRecordEventDateFreeForm, '')
From @t2
Where IsNull(MarriageRecordpkCPClientMarriageRecord,0) <> 0

Select Distinct pkCPJoinCPClientCPClientrefRelationship = RelationshippkCPJoinCPClientCPClientrefRelationship
		,fkCPClientParent = RelationshipfkCPClientParent
		,fkCPClientChild = RelationshipfkCPClientChild
		,fkParentCPrefClientRelationshipType = RelationshipfkParentCPrefClientRelationshipType
		,fkChildCPrefClientRelationshipType = RelationshipfkChildCPrefClientRelationshipType
from @t
where IsNull(RelationshippkCPJoinCPClientCPClientrefRelationship, 0) <> 0
