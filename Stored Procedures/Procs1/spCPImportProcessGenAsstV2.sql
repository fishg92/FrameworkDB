
CREATE    Proc [dbo].[spCPImportProcessGenAsstV2]
(	
	@pkCPImportBatch int
)

as

Declare @HostName varchar(100)
		,@ImportCreateUser varchar(20)
		,@pkCPImportGenAsst decimal (18,0)
		,@ImportLogEventType decimal(18,0)
		,@CaseNumPrevious varchar(50)
		,@inSex varchar(10)
		,@inSSN varchar(20)
		,@inBirthDate datetime
		,@CaseNum varchar(50)
		,@LocalCaseNum varchar(50)
		,@LastCaseNum varchar(50)
		,@chFirstName varchar(50)
		,@chLastName varchar(50)
		,@chMiddleName varchar(50)
		,@chSex varchar(50)
		,@chID varchar(20)
		,@pkCPClient decimal (18,0)
		,@pkCPClientCase decimal (18,0)
		,@pkCPClientAddress decimal (18,0)
		,@pkCPJoinClientClientCase decimal (18,0)
		,@pkCPJoinClientClientAddress decimal (18,0)
		,@pkCPClientPhone decimal (18,0)
		,@pkCPJoinClientClientPhone decimal (18,0)
		,@inFirstName varchar(50)
		,@inLastName varchar(50)
		,@inMiddleName varchar(50)
		,@inID varchar(20)
		,@Street1 varchar(100)
		,@Street2 varchar(100)
		,@City varchar(50)
		,@State varchar(10)
		,@Zip varchar(10)
		,@ZipPlusFour varchar(4)
		,@SSN varchar(20)
		,@WorkerNum varchar(10)
		,@BirthDate datetime
		,@Sex varchar(1)
		--,@Phone varchar(10)  FSIS does not have phone number on it
		,@LockedDate datetime
		,@lf int
		,@lf2 int
		,@lf3 int
		,@pkCPImportLog decimal
		,@CityState varchar(100)
		,@bCaseHeadPreviouslyProcessed tinyint
		,@bIndividualPreviouslyProcessed tinyint
		,@pkProgramType decimal (18,0)

select @HostName = host_name()
exec dbo.spCPImportPreChecks

select @pkProgramType = pkProgramType 
from ProgramType
where ProgramType = 'GenAsst'

select @pkProgramType = isnull(@pkProgramType, -1)

Select @ImportCreateUser = CreateUser 
From CPImportBatch with (nolock)
where pkCPImportBatch = @pkCPImportBatch

Declare cImportKeys INSENSITIVE Cursor For
	Select pkCPImportGenAsst
	From CPImportGenAsst with (nolock)
	Where fkCPImportBatch = @pkCPImportBatch 
	and ProcessDate is Null 
	Order by CaseID
		, case when CaseHeadIndividualID = ParticipantIndividualID then 0
				else 1
				end

Open cImportKeys

Fetch Next From cImportKeys into @pkCPImportGenAsst
Set @lf = @@Fetch_Status

Set @CaseNumPrevious = '~~No Match~~'
While @lf = 0
begin
	Select 	
		@CaseNum = CaseID
		,@SSN = SSNFormatted
		,@LocalCaseNum = CountyCaseNum
		,@chFirstName = CaseHeadFirstName
		,@chMiddleName = CaseHeadMiddleName
		,@chLastName = CaseHeadLastName
		,@chID = CaseHeadIndividualID
		,@chSex = CaseHeadSex
		,@inFirstName = ParticipantFirstName
		,@inMiddleName = ParticipantMiddleName
		,@inLastName = ParticipantLastName
		,@inID = ParticipantIndividualID
		,@inSex = ParticipantSex
		,@inSSN = SSNFormatted
		,@inBirthDate = BirthDate
		,@Street1 = Street1
		,@Street2 = Street2
		--,@City = City
		--,@State = [State]
		,@CityState = CityState
		,@Zip = Zip
		,@ZipPlusFour = ZipPlus4
		,@WorkerNum = WorkerNum	
	From	CPImportGenAsst with (nolock)
	Where	pkCPImportGenAsst = @pkCPImportGenAsst

	select @CityState = rtrim(ltrim(@CityState))
	
	if LEN(@CityState) > 2 
		begin
			select @State = ltrim(substring(@CityState,len(@CityState)-1,2))
			select @City = substring(@CityState,1,len(@CityState)-2)
			select @City = rtrim(replace(@City,',',''))
		end
	else
		begin
			select @City = '?'
				   ,@State = '?'
		end

	if @CaseNumPrevious <> @CaseNum begin
		Set @bCaseHeadPreviouslyProcessed = 1

	 -- did this person already process today? Will need to add other program type checks here
		if not exists (Select * From CPImportGenAsst with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null)
			And not exists (Select * From CPImportCalWorks with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportCAPI with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportFoodStamps with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportGenAsst with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportMediCal with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportTANF with (nolock)
						Where (CaseHeadIndividualID = @chID
							Or ParticipantIndividualID = @chID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			Begin
				Set @bCaseHeadPreviouslyProcessed = 0
			end

		if @chID = @inID 
			begin
			-- Case Head
				Exec spCPImportCPClientV2	
					@FirstName = @chFirstName
					,@LastName = @chLastName
					,@MiddleName = @chMiddleName
					,@SSN = @inSSN
					,@BirthDate = @inBirthDate
					,@StateIssuedNumber = @chID
					,@Sex = @ChSex
					,@bClientPreviouslyUpdated = @bCaseHeadPreviouslyProcessed
					,@pkCPClient = @pkCPClient Output
					,@pkCPRefImportLogEventType = @ImportLogEventType Output	 -- Move Logging to SP
			end 
		else 
			begin
				Exec spCPImportCPClientV2	
					@FirstName = @chFirstName
					,@LastName = @chLastName
					,@MiddleName = @chMiddleName
					,@SSN = '000000000'
					,@BirthDate = null
					,@StateIssuedNumber = @chID
					,@Sex = @ChSex
					,@bClientPreviouslyUpdated = @bCaseHeadPreviouslyProcessed
					,@pkCPClient = @pkCPClient Output
					,@pkCPRefImportLogEventType = @ImportLogEventType Output	 -- Move Logging to SP
			end
		
		Exec spCPImportCPClientCaseV2	
			@StateCaseNumber = @CaseNum
			,@LocalCaseNumber = @LocalCaseNum
			,@CaseWorkerCode = @WorkerNum
			,@pkCPRefClientCaseProgramType = @pkProgramType
			,@fkCPClientCaseHead = @pkCPClient
			,@pkrefClientCaseImportSource = 4
			,@pkCPClientCase = @pkCPClientCase Output
			,@pkCPRefImportLogEventType = @ImportLogEventType Output	-- Move Logging to SP

		Exec spCPImportCPJoinClientClientCaseV2	
			@fkCPClient = @pkCPClient
			,@fkCPClientCase = @pkCPClientCase
			,@PrimaryParticipantOnCase = 1
			,@pkCPJoinClientClientCase = @pkCPJoinClientClientCase Output
			,@pkCPRefImportLogEventType = @ImportLogEventType Output

		Exec spCPImportCPClientAddressV2	
			@Street1 = @Street1
			,@Street2 = @Street2
			,@City = @City
			,@State = @State
			,@Zip = @Zip
			,@ZipPlus4  = @ZipPlusFour
			,@pkCPRefAddressType = 1
			,@pkCPClientAddress = @pkCPClientAddress Output
			,@pkCPRefImportLogEventType = @ImportLogEventType Output

		if @bCaseHeadPreviouslyProcessed = 0 
			Begin
				Exec spCPImportCPJoinClientClientAddressV2	
					 @fkCPClient = @pkCPClient
					 ,@fkCPClientAddress = @pkCPClientAddress
					 ,@fkCPRefAddressType = 1
					 ,@pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress Output
					 ,@pkCPRefImportLogEventType = @ImportLogEventType Output	
			end
	end	

	Set @bIndividualPreviouslyProcessed = 1

	-- Will need to add other program type checks here
 	if not exists (Select * From CPImportGenAsst with (nolock)
					Where (CaseHeadIndividualID = @inID
						Or ParticipantIndividualID = @inID)
					And	fkCPImportBatch = @pkCPImportBatch 
					And ProcessDate is not null)
		    And not exists (Select * From CPImportCalWorks with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportCAPI with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportFoodStamps with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportGenAsst with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportMediCal with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
			And not exists (Select * From CPImportTANF with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) 
		Begin
			Set @bIndividualPreviouslyProcessed = 0
		end

	declare @IndividualIsCaseHead as decimal
	set @IndividualIsCaseHead = 0

	if @inID = @chID begin  
		set @bIndividualPreviouslyProcessed = 1
		set @IndividualIsCaseHead = 1
	end
	
	Exec spCPImportCPClientV2	
		 @FirstName = @inFirstName
		 ,@LastName = @inLastName
		 ,@MiddleName = @inMiddleName
		 ,@SSN = @inSSN
		 ,@BirthDate = @inBirthDate
		 ,@StateIssuedNumber = @inID
		 ,@Sex = @inSex
		 ,@bClientPreviouslyUpdated = @bIndividualPreviouslyProcessed
		 ,@pkCPClient = @pkCPClient Output
		 ,@pkCPRefImportLogEventType = @ImportLogEventType Output	 -- Move Logging to SP

	Exec spCPImportCPJoinClientClientCaseV2	
		 @fkCPClient = @pkCPClient
		 ,@fkCPClientCase = @pkCPClientCase
		 ,@PrimaryParticipantOnCase = @IndividualIsCaseHead
		 ,@pkCPJoinClientClientCase = @pkCPJoinClientClientCase Output
		 ,@pkCPRefImportLogEventType = @ImportLogEventType Output

	Exec spCPImportCPClientAddressV2	
		 @Street1 = @Street1
		 ,@Street2 = @Street2
		 ,@City = @City
		 ,@State = @State
		 ,@Zip = @Zip
		 ,@ZipPlus4  = @ZipPlusFour
		 ,@pkCPRefAddressType = 1
		 ,@pkCPClientAddress = @pkCPClientAddress Output
		 ,@pkCPRefImportLogEventType = @ImportLogEventType Output

	if @bIndividualPreviouslyProcessed = 0 
		Begin
			Exec spCPImportCPJoinClientClientAddressV2	
				 @fkCPClient = @pkCPClient
				 ,@fkCPClientAddress = @pkCPClientAddress
				 ,@fkCPRefAddressType = 1
				 ,@pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress Output
				 ,@pkCPRefImportLogEventType = @ImportLogEventType Output	
		end

	Update CPImportGenAsst 
	Set ProcessDate = GetDate() 
	Where pkCPImportGenAsst = @pkCPImportGenAsst

	set @CaseNumPrevious = @CaseNum
	Fetch next From cImportKeys Into @pkCPImportGenAsst
	Set @lf = @@Fetch_Status
end

Close cImportKeys
Deallocate cImportKeys

--if 1 = 2 begin 
--	select @EffectiveDate = max(EffectiveDate)
--	from dbo.CPImportGenAsst with (nolock)
--	where fkCPImportBatch = @pkCPImportBatch

--	select 
--		pkCPJoinClientClientCase
--		,c.StateCaseNumber
--		,cl.SSN
--	into #Intermediate
--	from CPJoinClientClientCase j with (nolock)
--	inner join CPClientCase c with (nolock) on c.pkCPClientCase = j.fkCPClientCase
--	inner join CPClient cl with (nolock) on cl.pkCPClient = j.fkCPClient
--	where 1=1 
--	and c.StateCaseNumber in (
--					select ic.CaseID 
--					from CPImportGenAsst ic with (nolock)
--					where ic.fkCPImportBatch = @pkCPImportBatch
--					)
--	and j.PrimaryParticipantOnCase <> 1

--	Declare cDelete INSENSITIVE Cursor For
--		select 
--			pkCPJoinClientClientCase
--			,EffectiveDateOfDelete = max(i.EffectiveDate)
--		from #Intermediate j with (nolock)
--		inner join dbo.CPImportGenAsst i with (nolock) on i.CaseID = j.StateCaseNumber
--												and i.SSNFormatted = j.SSN
--		group by 
--		pkCPJoinClientClientCase
--		having datediff(day,max(i.EffectiveDate),@EffectiveDate) >= abs(dbo.RecentDaysConstant())

--	Open cDelete

--	Fetch Next from cDelete 
--			Into @pkCPJoinClientClientCase
--				,@EffectiveDateOfDelete
--	Set @lf3 = @@Fetch_Status

--	While @lf3 = 0
--	begin
--		if not exists (select * 
--						from CPJoinClientClientCase with (nolock)
--						where pkCPJoinClientClientCase = @pkCPJoinClientClientCase
--						and datediff(day,CreateDate,getdate()) <= abs(dbo.RecentDaysConstant() )
--					   )
--		begin
--			exec dbo.uspCPJoinClientClientCaseDelete
--				@pkCPJoinClientClientCase=@pkCPJoinClientClientCase
--				, @LUPUser=@HostName
--				, @LUPMac=@HostName
--				, @LUPIP=@HostName
--				, @LUPMachine=@HostName

--			exec dbo.spCPInsertCPImportLog
--				@pkCPImportLog = @pkCPImportLog Output
--				,@fkCPRefImportLogEventType = 1
--				,@fkCPJoinClientClientCase = @pkCPJoinClientClientCase
--		end

--		Fetch Next from cDelete 
--				Into @pkCPJoinClientClientCase
--					,@EffectiveDateOfDelete
--		Set @lf3 = @@Fetch_Status
--	end

--	Close cDelete
--	Deallocate cDelete

--	drop table #Intermediate
--end
