
CREATE procedure [dbo].[spCPGetClientCaseForPointInTime]
(
	@pkApplicationUser decimal,
	@FirstName varchar(100) = null,
	@LastName varchar(100) = null,
	@SSN varchar(12) = null,
	@StateCaseNumber varchar(20) = null,
	@LocalCaseNumber varchar(20) = null,
	@NorthwoodsNumber varchar(50) = null,
	@BirthDate datetime = null,
	@SISNumber varchar(11) = null,
	@StateIssuedNumber varchar (50) = null
	,@pkCPClient decimal = null
	,@IncludeInactive bit = 0
)

as

set nocount on

if @pkCPClient is not null
	begin
	select @NorthwoodsNumber = NorthwoodsNumber
	from	CPClient
	where	pkCPClient = @pkCPClient
	end

--Remove blanks and hyphens from ssn
if @SSN is not null
	set @SSN = replace(replace(@SSN,'-',''),' ','')

--Remove time portion from birth date
if @BirthDate is not null
	set @BirthDate = dbo.DatePortion(@BirthDate)


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
	,ClientEmail varchar(250)

	,JoinpkCPJoinClientClientCase decimal(18, 0)
	,JoinfkCPClientCase decimal(18, 0)
	,JoinfkCPClient decimal(18, 0)
	,JoinPrimaryParticipantOnCase tinyint

	,CasepkCPClientCase decimal(18, 0)
	,CaseStateCaseNumber varchar(20)
	,CaseLocalCaseNumber varchar(20)
	,CasefkCPRefClientCaseProgramType nvarchar(50)
	,CasefkApplicationUser decimal (18,0)
	,CaseStatus bit
)

		/* Separate insert statements for most common parameter sets */
		
		--StateCaseNumber
		if @FirstName is null
		and @LastName is null
		and @SSN is null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is not null
		and @LocalCaseNumber is null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
						from CPClientCase cc1 with (nolock)
						join JoinApplicationUserProgramType upt with (nolock)
							on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
						where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where cc.StateCaseNumber Like @StateCaseNumber + '%'
			option (recompile)
	
			end
		
		--LocalCaseNumber
		else if @FirstName is null
		and @LastName is null
		and @SSN is null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is null
		and @LocalCaseNumber is not null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where cc.LocalCaseNumber Like @LocalCaseNumber + '%'
			option (recompile)
	
			end

		--State and LocalCaseNumber
		else if @FirstName is null
		and @LastName is null
		and @SSN is null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is not null
		and @LocalCaseNumber is not null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where cc.StateCaseNumber = @StateCaseNumber
			and  cc.LocalCaseNumber Like @LocalCaseNumber + '%'
			option (recompile)
	
			end
		
		--SSN
		else if @FirstName is null
		and @LastName is null
		and @SSN is not null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is null
		and @LocalCaseNumber is null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus
				
			From 	CPClient c with (NoLock)
			left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			left Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where c.SSN = @SSN
			option (recompile)
	
			end
		
		--NorthwoodsNumber
		else if @FirstName is null
		and @LastName is null
		and @SSN is null
		and @NorthwoodsNumber is not null
		and @StateCaseNumber is null
		and @LocalCaseNumber is null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			left Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where c.NorthwoodsNumber Like @NorthwoodsNumber + '%'
			option (recompile)
	
			end
		
		--First and last name
		else if @FirstName is not null
		and @LastName is not null
		and @SSN is null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is null
		and @LocalCaseNumber is null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			left Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where c.FirstName Like @FirstName + '%'
			and   c.LastName Like @LastName + '%'
			option (recompile)

			end
		
		--Last, First, SSN
		else if @FirstName is not null
		and @LastName is not null
		and @SSN is not null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is null
		and @LocalCaseNumber is null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			left Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where c.FirstName Like @FirstName + '%'
			and   c.LastName Like @LastName + '%'
			and c.SSN = @SSN
			option (recompile)

			end
		
		--Last name
		else if @FirstName is null
		and @LastName is not null
		and @SSN is null
		and @NorthwoodsNumber is null
		and @StateCaseNumber is null
		and @LocalCaseNumber is null
		and @BirthDate is null
		and @StateIssuedNumber is null
		and @SISNumber is null
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			left Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where c.LastName Like @LastName + '%'
			option (recompile)

			end
		
		--All other combinations
		else
			begin
			with cc as (select cc1.*
			from CPClientCase cc1 with (nolock)
			join JoinApplicationUserProgramType upt with (nolock)
				on upt.fkProgramType = cc1.fkCPRefClientCaseProgramType
			where upt.fkApplicationUser = @pkApplicationUser)
			insert into @t5
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
				,c.Email

				,j.pkCPJoinClientClientCase
				,j.fkCPClientCase
				,j.fkCPClient
				,j.PrimaryParticipantOnCase 

				,cc.pkCPClientCase
				,cc.StateCaseNumber
				,cc.LocalCaseNumber
				,cc.fkCPRefClientCaseProgramType
				,cc.fkApplicationUser 
				,cc.CaseStatus

			From 	CPClient c with (NoLock)
			left Join CPJoinClientClientCase j with (NoLock) on j.fkCPClient = c.pkCPClient 
			left Join cc on cc.pkCPClientCase = j.fkCPClientCase
			Where (@FirstName is null or c.FirstName Like @FirstName + '%')
			and   (@LastName is null or c.LastName Like @LastName + '%')
			and   (@SSN is null or c.SSN = @SSN)
			and   (@NorthwoodsNumber is null or c.NorthwoodsNumber Like @NorthwoodsNumber + '%')
			and   (@StateCaseNumber is null or cc.StateCaseNumber Like @StateCaseNumber + '%')
			and   (@LocalCaseNumber is null or cc.LocalCaseNumber Like @LocalCaseNumber + '%')
			and   (@BirthDate is null or c.BirthDate = @BirthDate)
			and   (@StateIssuedNumber is null or c.StateIssuedNumber Like @StateIssuedNumber + '%')
			and   (@SISNumber is null or c.SISNumber Like @SISNumber + '%')
			option (recompile)
			end
Select distinct	pkCPClient = ClientpkCPClient
		,LastName = case when upper(isnull(ClientLastName, '#EMPTY')) = '#EMPTY' then '' else ClientLastName end
		,FirstName = case when upper(isnull(ClientFirstName, '#EMPTY')) = '#EMPTY' then '' else ClientFirstName end
		,MiddleName = case when upper(isnull(ClientMiddleName, '#EMPTY')) = '#EMPTY' then '' else ClientMiddleName end
		,SSN = case when upper(isnull(ClientSSN, '#EMPTY')) = '#EMPTY' then '' else ClientSSN end
		,NorthwoodsNumber = case when upper(isnull(ClientNorthwoodsNumber, '#EMPTY')) = '#EMPTY' then '' else ClientNorthwoodsNumber end
		,StateIssuedNumber = case when upper(isnull(ClientStateIssuedNumber, '#EMPTY')) = '#EMPTY' then '' else ClientStateIssuedNumber end
		,BirthDate = ClientBirthDate
		,Suffix = Isnull(ClientSuffix, '')
		,SISNumber = Isnull(ClientSISNumber, '')
		,Email = ISNULL(ClientEmail, '')
from 	@t5
Where	IsNull(ClientpkCPClient,0) <> 0

select distinct	pkCPClientCase = CasepkCPClientCase
		,StateCaseNumber = case when upper(isnull(CaseStateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseStateCaseNumber end
		,LocalCaseNumber = case when upper(isnull(CaseLocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseLocalCaseNumber end
		,fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType
		,fkApplicationUser = CasefkApplicationUser 
		,CaseStatus
from 	@t5
Where	IsNull(CasepkCPClientCase,0) <> 0
and		CaseStatus = 1

union

select distinct	pkCPClientCase = CasepkCPClientCase
		,StateCaseNumber = case when upper(isnull(CaseStateCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseStateCaseNumber end
		,LocalCaseNumber = case when upper(isnull(CaseLocalCaseNumber, '#EMPTY')) = '#EMPTY' then '' else CaseLocalCaseNumber end
		,fkCPRefClientCaseProgramType = CasefkCPRefClientCaseProgramType
		,fkApplicationUser = CasefkApplicationUser 
		,CaseStatus
from 	@t5
Where	IsNull(CasepkCPClientCase,0) <> 0
and		CaseStatus = 0 and @IncludeInactive = 1

Select distinct	pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
		,fkCPClientCase = JoinfkCPClientCase
		,fkCPClient = JoinfkCPClient
		,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase,0) 
from 	@t5
Where	IsNull(JoinpkCPJoinClientClientCase,0) <> 0
and		CaseStatus = 1

union

Select distinct	pkCPJoinClientClientCase = JoinpkCPJoinClientClientCase
		,fkCPClientCase = JoinfkCPClientCase
		,fkCPClient = JoinfkCPClient
		,PrimaryParticipantOnCase = isnull(JoinPrimaryParticipantOnCase,0) 
from 	@t5
Where	IsNull(JoinpkCPJoinClientClientCase,0) <> 0
and		CaseStatus = 0 and @IncludeInactive = 1
