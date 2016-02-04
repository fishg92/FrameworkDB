
--exec [dbo].[spCPGetClientCaseOverview]'OH123000000066'
-- exec spCPGetClientCaseOverview @NorthwoodsNumber='OH123000001158', @IncludeInactive =0

CREATE procedure [dbo].[spCPGetClientCaseOverview]
(
	@NorthwoodsNumber varchar(50),
	@IncludeInactive bit = 0
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
	,ClientSex char(1)
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
	,ClientHomePhone varchar(10)
	,ClientCellPhone varchar(10)
	,ClientBirthLocation varchar(100)
	,ClientMaidenName varchar(100)
	,ClientSchoolName varchar(100)
	,ClientEducationType decimal(18,0)
	,ClientEmail VARCHAR(250)

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
	,CasefkApplicationUser decimal(18, 0)
	,CaseStatus bit
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
	,ClientSex char(1)
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
	,ClientHomePhone varchar(10)
	,ClientCellPhone varchar(10)
	,ClientBirthLocation varchar(100)
	,ClientMaidenName varchar(100)
	,ClientSchoolName varchar(100)
	,ClientEducationType decimal(18,0)
	,ClientEmail VARCHAR(250)

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
	,CasefkApplicationUser decimal(18, 0)
	,CaseStatus bit
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
	,ClientSex char(1)
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
	,ClientHomePhone varchar(10)
	,ClientCellPhone varchar(10)
	,ClientBirthLocation varchar(100)
	,ClientMaidenName varchar(100)
	,ClientSchoolName varchar(100)
	,ClientEducationType decimal(18,0)
	,ClientEmail VARCHAR(250)

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
	,CasefkApplicationUser decimal(18, 0)
	,CaseStatus bit

	,CaseNumberFilterpkCPClientCase decimal

	,JoinClientAlertpkCPJoinClientAlertFlagTypeNT decimal(18, 0)
	,JoinClientAlertfkCPClient decimal(18, 0)
	,JoinClientAlertfkRefCPAlertFlagTypeNT decimal(18, 0)

	,RelationshippkCPJoinCPClientCPClientrefRelationship decimal
	,RelationshipfkCPClientParent decimal
	,RelationshipfkCPClientChild decimal
	,RelationshipfkParentCPrefClientRelationshipType decimal
	,RelationshipfkChildCPrefClientRelationshipType decimal
)

/* need to get all cases based on intial search to find members of those cases */
Declare @ClientCaseFilter table
(	
	pkCPClientCase decimal 
)

begin
	insert into @PrimaryClients
	select c.pkCPClient
		,c.LastName
		,c.FirstName
		,c.MiddleName
		,c.SSN
		,c.NorthwoodsNumber
		,c.StateIssuedNumber
		,c.BirthDate
		,c.Sex
		,c.Suffix
		,c.SISNumber
		,c.HomePhone
		,c.CellPhone
		,c.BirthLocation
		,c.MaidenName
		,c.SchoolName
		,c.fkCPRefClientEducationType
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
		,cc.fkApplicationUser
		,cc.CaseStatus
	From 	CPClient c with (NoLock)
	left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
	left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
	where 
		j.fkCPClientCase in
		(
			select	j2.fkCPClientCase
			from	dbo.CPClient c2
			join dbo.CPJoinClientClientCase j2 on c2.pkCPClient = j2.fkCPClient
			join dbo.CPClientCase cc2 on j2.fkCPClientCase = cc2.pkCPClientCase		
			where c2.NorthwoodsNumber = @NorthwoodsNumber
		)

	union

	select c.pkCPClient
		,c.LastName
		,c.FirstName
		,c.MiddleName
		,c.SSN
		,c.NorthwoodsNumber
		,c.StateIssuedNumber
		,c.BirthDate
		,c.Sex
		,c.Suffix
		,c.SISNumber
		,c.HomePhone
		,c.CellPhone
		,c.BirthLocation
		,c.MaidenName
		,c.SchoolName
		,c.fkCPRefClientEducationType
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
		,cc.fkApplicationUser
		,cc.CaseStatus
	From 	CPClient c with (NoLock)
	left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
	left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
	where c.NorthwoodsNumber = @NorthwoodsNumber

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
		,c.Sex
		,c.Suffix
		,c.SISNumber
		,c.HomePhone
		,c.CellPhone
		,c.BirthLocation
		,c.MaidenName
		,c.SchoolName
		,c.fkCPRefClientEducationType
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
		,cc.fkApplicationUser
		,cc.CaseStatus
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
		,c.Sex
		,c.Suffix
		,c.SISNumber
		,c.HomePhone
		,c.CellPhone
		,c.BirthLocation
		,c.MaidenName
		,c.SchoolName
		,c.fkCPRefClientEducationType
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
		,cc.fkApplicationUser
		,cc.CaseStatus
	From 	CPClient c with (NoLock)
	left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
	left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
	where c.pkCPClient in (select fkCPClientChild
							from CPJoinCPClientCPClientrefRelationship cjcr (NoLock)
							join @PrimaryClients pc on pc.ClientpkCPClient = cjcr.fkCPClientParent)

	insert into @ClientCaseFilter
	select t5.CasepkCPClientCase 
	From @t5 t5
	Where t5.ClientNorthwoodsNumber = @NorthwoodsNumber

	insert into @t
	select  t5.*
		,ccf.pkCPClientCase
		
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
	Left join CPJoinClientAlertFlagTypeNT cja with (NoLock) on cja.fkCPClient = t5.ClientpkCPClient
	Left Join CPJoinCPClientCPClientrefRelationship cjcr with (NoLock) on cjcr.fkCPClientParent = t5.ClientpkCPClient
	
	union

	select  t5.*
		,t5.CasepkCPClientCase

		,cja.pkCPJoinClientAlertFlagTypeNT
		,cja.fkCPClient
		,cja.fkRefCPAlertFlagTypeNT

		,cjcr.pkCPJoinCPClientCPClientrefRelationship
		,cjcr.fkCPClientParent
		,cjcr.fkCPClientChild
		,cjcr.fkParentCPrefClientRelationshipType
		,cjcr.fkChildCPrefClientRelationshipType
						 
	From @t5 t5
	Left join CPJoinClientAlertFlagTypeNT cja with (NoLock) on cja.fkCPClient = t5.ClientpkCPClient
	Left Join CPJoinCPClientCPClientrefRelationship cjcr with (NoLock) on cjcr.fkCPClientParent = t5.ClientpkCPClient
end

Select distinct	pkCPClient = ClientpkCPClient
		,LastName = case when upper(isnull(ClientLastName, '#EMPTY')) = '#EMPTY' then '' else ClientLastName end
		,FirstName = case when upper(isnull(ClientFirstName, '#EMPTY')) = '#EMPTY' then '' else ClientFirstName end
		,MiddleName = case when upper(isnull(ClientMiddleName, '#EMPTY')) = '#EMPTY' then '' else ClientMiddleName end
		,SSN = case when upper(isnull(ClientSSN, '#EMPTY')) = '#EMPTY' then '' else ClientSSN end
		,NorthwoodsNumber = case when upper(isnull(ClientNorthwoodsNumber, '#EMPTY')) = '#EMPTY' then '' else ClientNorthwoodsNumber end
		,StateIssuedNumber = case when upper(isnull(ClientStateIssuedNumber, '#EMPTY')) = '#EMPTY' then '' else ClientStateIssuedNumber end
		,BirthDate = ClientBirthDate
		,Sex = case when upper(isnull(ClientSex, '#')) = '#' then '' else ClientSex end
		,Suffix = Isnull(ClientSuffix, '')
		,SISNumber = Isnull(ClientSISNumber, '')
		,HomePhone = ClientHomePhone
		,CellPhone = ClientCellPhone
		,BirthLocation = ClientBirthLocation
		,MaidenName	= ISNULL(ClientMaidenName,'')
		,SchoolName = ISNULL(ClientSchoolName,'')
		,fkCPRefClientEducationType = ClientEducationType
		,Email = ISNULL(ClientEmail, '')
from 	@t
Where	IsNull(ClientpkCPClient,0) <> 0

select distinct	pkCPClientCase = CasepkCPClientCase
		,StateCaseNumber = case when upper(isnull(CaseStateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseStateCaseNumber end
		,LocalCaseNumber = case when upper(isnull(CaseLocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseLocalCaseNumber end
		,fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType
		,fkCPCaseWorker = CasefkCPCaseWorker
		,fkApplicationUser = CasefkApplicationUser
		,CaseStatus
from 	@t
Where	IsNull(CasepkCPClientCase,0) <> 0
and		CaseStatus = 1

union

select distinct	pkCPClientCase = CasepkCPClientCase
		,StateCaseNumber = case when upper(isnull(CaseStateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseStateCaseNumber end
		,LocalCaseNumber = case when upper(isnull(CaseLocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseLocalCaseNumber end
		,fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType
		,fkCPCaseWorker = CasefkCPCaseWorker
		,fkApplicationUser = CasefkApplicationUser
		,CaseStatus
from 	@t
Where	IsNull(CasepkCPClientCase,0) <> 0
and		CaseStatus = 0 and @IncludeInactive = 1


Select distinct	pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
		,fkCPClientCase = JoinfkCPClientCase
		,fkCPClient = JoinfkCPClient
		,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase, 0)
		,fkCPRefClientRelationshipType = JoinfkCPRefClientRelationshipType
		,LockedUser = isnull(JoinLockedUser, '')
		,LockedDate = JoinLockedDate
from 	@t
Where	IsNull(JoinpkCPJoinClientClientCase,0) <> 0
and		CaseStatus = 1

union 

Select distinct	pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
		,fkCPClientCase = JoinfkCPClientCase
		,fkCPClient = JoinfkCPClient
		,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase, 0)
		,fkCPRefClientRelationshipType = JoinfkCPRefClientRelationshipType
		,LockedUser = isnull(JoinLockedUser, '')
		,LockedDate = JoinLockedDate
from 	@t
Where	IsNull(JoinpkCPJoinClientClientCase,0) <> 0
and		CaseStatus = 0 and @IncludeInactive = 1

select distinct	pkCPJoinClientAlertFlagTypeNT = JoinClientAlertpkCPJoinClientAlertFlagTypeNT
		,fkCPClient = JoinClientAlertfkCPClient
		,fkRefCPAlertFlagTypeNT = JoinClientAlertfkRefCPAlertFlagTypeNT
From @t
where isnull(JoinClientAlertpkCPJoinClientAlertFlagTypeNT, 0) <> 0

Select Distinct pkCPJoinCPClientCPClientrefRelationship = RelationshippkCPJoinCPClientCPClientrefRelationship
		,fkCPClientParent = RelationshipfkCPClientParent
		,fkCPClientChild = RelationshipfkCPClientChild
		,fkParentCPrefClientRelationshipType = RelationshipfkParentCPrefClientRelationshipType
		,fkChildCPrefClientRelationshipType = RelationshipfkChildCPrefClientRelationshipType
from @t
where IsNull(RelationshippkCPJoinCPClientCPClientrefRelationship, 0) <> 0


Select  distinct c.pkCPClient
From	(Select Distinct ClientpkCPClient as pkCPClient From @t) c
join	CPCaseActivity ca (NoLock) on ca.fkCPClient = c.pkCPClient
