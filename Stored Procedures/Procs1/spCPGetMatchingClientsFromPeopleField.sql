CREATE PROCEDURE [dbo].[spCPGetMatchingClientsFromPeopleField]
	  @Table varchar(50)
	, @Field varchar(100)
	, @Value varchar(500)
AS

Declare @BaseSQL As Varchar(max)
Declare @WHERE As Varchar(max)
Declare @Join As Varchar(500)

set @Table = (Select Replace(@Table, 'dbo.',''))

If LOWER(@Field) = 'ssn'
	set @Value = (Select Replace(@Value, '-',''))

create table #temptable (pkcpclient decimal (18,0))
------------------------------------------------

Set @BaseSQL = ('insert into #temptable select distinct pkCpClient from dbo.CPClient c')
Set @Where = (' Where ' + @Field + ' = '''  + @Value + '''')
Set @Join = (' x (nolock) on c.pkCPClient = x.fkcpClient ') 
set @Join = @Join +  ' Inner Join ' + @Table + ' t (nolock) on x.fk' + @Table + ' =  t.pk' + @Table 

If LOWER(@Table) = 'cpclient' 
	Set @BaseSQL = (@BaseSQL + @Where)
If LOWER(@Table) = 'cpclientaddress' 
    Set @BaseSQL = (@BaseSQL + ' Inner Join dbo.CPJoinClientClientAddress ' + @Join +  @Where)
If LOWER(@Table) = 'cpemployer' 
	Set @BaseSQL = (@BaseSQL + ' Inner Join dbo.CPJoinClientEmployer ' + @Join +  @Where)
If LOWER(@Table) = 'cpclientmarriagerecord' 
	Set @BaseSQL = ('insert into #temptable select distinct fkCpClient as pkcpclient from dbo.CPClientMarriageRecord ' +  @Where)
If LOWER(@Table) = 'cpclientmilitaryrecord'
    Set @BaseSQL = ('insert into #temptable select distinct fkCpClient as pkcpclient from dbo.CPClientMilitaryRecord ' +  @Where)
If LOWER(@Table) = 'columnnamefriendlynamemapping'
	Begin
		Declare @Column As varchar (250)
		set @Column =  
		(select ColumnName from ColumnNameFriendlyNameMapping 
		where TableName = 'CPClientCustomAttribute' and FriendlyName = @Field)
		set @BaseSQL = 'insert into #temptable select distinct fkcpclient as pkcpclient from dbo.CPClientCustomAttribute (nolock) where ' + @Column + ' =  ''' + @Value + ''''
	End

exec(@BaseSQL)

create table #NorthwoodsTable (NorthwoodsNumber varchar (50))

insert into #NorthwoodsTable select NorthwoodsNumber from CpClient (nolock) where pkcpclient in (select pkcpclient from #temptable)

drop table #temptable

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
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
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
	,CasefkApplicatinUser decimal(18,0)
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
	,ClientSuffix Varchar(20)
	,ClientSISNumber varchar(11)
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
	,CasefkApplicationUser decimal(18,0)
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
			,c.Suffix
			,c.SISNumber
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
			,cc.fkApplicationUser
		From 	CPClient c with (NoLock)
		left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient
		left Join CPClientCase cc with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
		where  c.NorthwoodsNumber in (select NorthwoodsNumber from #NorthwoodsTable)
			

		insert into @t5
		select top 100 * from @PrimaryClients

		insert into @ClientCaseFilter
		select t5.CasepkCPClientCase 
		From @t5 t5
		where  (t5.ClientNorthwoodsNumber in (select NorthwoodsNumber from #NorthwoodsTable))

		
Select distinct	pkCPClient = ClientpkCPClient,
		LastName = case when upper(isnull(ClientLastName, '#EMPTY')) = '#EMPTY' then '' else ClientLastName end,
		FirstName = case when upper(isnull(ClientFirstName, '#EMPTY')) = '#EMPTY' then '' else ClientFirstName end,
		MiddleName = case when upper(isnull(ClientMiddleName, '#EMPTY')) = '#EMPTY' then '' else ClientMiddleName end,
		SSN = case when upper(isnull(ClientSSN, '#EMPTY')) = '#EMPTY' then '' else ClientSSN end,
		NorthwoodsNumber = case when upper(isnull(ClientNorthwoodsNumber, '#EMPTY')) = '#EMPTY' then '' else ClientNorthwoodsNumber end,
		StateIssuedNumber = case when upper(isnull(ClientStateIssuedNumber, '#EMPTY')) = '#EMPTY' then '' else ClientStateIssuedNumber end,
		BirthDate = ClientBirthDate,
		Suffix = Isnull(ClientSuffix, ''),
		SISNumber = Isnull(ClientSISNumber, ''),
		HomePhone = ClientHomePhone,
		CellPhone = ClientCellPhone,
		Email = ISNULL(ClientEmail, '')
		
from 	@t5
Where	IsNull(ClientpkCPClient,0) <> 0


select distinct	pkCPClientCase = CasepkCPClientCase,
		StateCaseNumber = case when upper(isnull(CaseStateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseStateCaseNumber end,
		LocalCaseNumber = case when upper(isnull(CaseLocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseLocalCaseNumber end,
		fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType,
		fkApplicationUser = CasefkApplicationUser
from 	@t5
Where	IsNull(CasepkCPClientCase,0) <> 0

Select distinct	pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
		,fkCPClientCase = JoinfkCPClientCase
		,fkCPClient = JoinfkCPClient
		,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase, 0)
		,fkCPRefClientRelationshipType = JoinfkCPRefClientRelationshipType
		,LockedUser = isnull(JoinLockedUser, '')
		,LockedDate = JoinLockedDate
from 	@t5
Where	IsNull(JoinpkCPJoinClientClientCase,0) <> 0
