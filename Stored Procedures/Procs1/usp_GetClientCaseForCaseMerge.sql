
CREATE procedure [dbo].[usp_GetClientCaseForCaseMerge]
( 
 @StateCaseNumber varchar(20) = '',
 @LocalCaseNumber varchar(20) = ''
)

as

declare @searchResults table
(
 ClientpkCPClient decimal(18, 0)
 ,ClientCompassNumber varchar (50)
 ,ClientLastName varchar(100)
 ,ClientFirstName varchar(100)
 ,ClientMiddleName varchar(100)
 ,ClientSuffix Varchar(20)

 ,JoinpkCPJoinClientClientCase decimal(18, 0)
 ,JoinfkCPClientCase decimal(18, 0)
 ,JoinfkCPClient decimal(18, 0)
 ,JoinPrimaryParticipantOnCase tinyint

 ,CasepkCPClientCase decimal(18, 0)
 ,CaseStateCaseNumber varchar(20)
 ,CaseLocalCaseNumber varchar(20)
 ,CasefkCPRefClientCaseProgramType nvarchar(50)
 ,CasefkApplicationUser decimal (18,0)
 ,CaseCaseStatus bit
)



insert into @searchResults
select   c.pkCPClient
	,c.NorthwoodsNumber 
	,c.LastName
	,c.FirstName
	,c.MiddleName
	,c.Suffix

	,ccjoin.pkCPJoinClientClientCase
	,ccjoin.fkCPClientCase
	,ccjoin.fkCPClient
	,ccjoin.PrimaryParticipantOnCase 

	,cc.pkCPClientCase
	,cc.StateCaseNumber
	,cc.LocalCaseNumber
	,cc.fkCPRefClientCaseProgramType
	,cc.fkApplicationUser
	,cc.CaseStatus  
from CPClientCase cc
  left join CPJoinClientClientCase ccjoin on ccjoin.fkCPClientCase = cc.pkCPClientCase
  left join CPClient c on c.pkCPClient = ccjoin.fkCPClient
where cc.StateCaseNumber like @StateCaseNumber + '%' 
  and cc.LocalCaseNumber like @LocalCaseNumber + '%'



Select distinct pkCPClient = ClientpkCPClient
  ,NorthwoodsNumber = isnull(ClientCompassNumber, '')
  ,LastName = isnull(ClientLastName, '')
  ,FirstName = isnull(ClientFirstName, '')
  ,MiddleName = isnull(ClientMiddleName, '') 
  ,SSN = '' 
  ,NorthwoodsNumber = ''
  ,StateIssuedNumber = ''
  ,BirthDate = null
  ,Suffix = Isnull(ClientSuffix, '')
  ,SISNumber = ''
from  @searchResults


select distinct pkCPClientCase = CasepkCPClientCase
  ,StateCaseNumber = isnull(CaseStateCaseNumber, '')
  ,LocalCaseNumber = isnull(CaseLocalCaseNumber, '')
  ,fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType
  ,fkApplicationUser = CasefkApplicationUser
  ,CaseStatus = CaseCaseStatus 
from  @searchResults


Select distinct pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
  ,fkCPClientCase = JoinfkCPClientCase
  ,fkCPClient = JoinfkCPClient
  ,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase,0) 
from  @searchResults