







CREATE    Proc [dbo].[spCPImportProcessEISv2](	
	@pkCPImportBatch int
)
as

Declare
	@HostName varchar(100)
	,@ImportCreateUser varchar(20)
	,@pkCPImportEISCase decimal (18,0)
	,@ImportLogEventType decimal(18,0)
	,@pkCPImportEISIndividual decimal (18,0)
	,@CaseNum varchar(50)
	,@LocalCaseNum varchar(50)
	,@LastCaseNum varchar(50)
	,@chFirstName varchar(50)
	,@chLastName varchar(50)
	,@chMiddleName varchar(50)
	,@chID varchar(20)
	,@pkCPClient decimal (18,0)
	,@pkCPClientCase decimal (18,0)
	,@pkCPClientAddress decimal (18,0)
	,@pkCPJoinClientClientCase decimal (18,0)
	,@pkCPJoinClientClientAddress decimal (18,0)
	,@pkCPClientPhone decimal (18,0)
	,@pkCPJoinClientClientPhone decimal (18,0)
	,@pkCPClientCaseHead decimal (18,0)
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
	--,@WorkerNum varchar(10)
	,@DistrictNo varchar(10)
	,@BirthDate datetime
	,@Sex varchar(1)
	,@Phone varchar(10)
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

--select @pkProgramType = pkProgramType 
--from ProgramType
--where ProgramType = 'EIS'

--select @pkProgramType = isnull(@pkProgramType, -1)
select @pkProgramType = 2
Select @ImportCreateUser = CreateUser 
From CPImportBatch with (nolock)
where pkCPImportBatch = @pkCPImportBatch

Declare cImportKeys INSENSITIVE Cursor  For
	Select pkCPImportEISCase 
	From CPImportEISCase with (nolock)
	Where fkCPImportBatch = @pkCPImportBatch 
	and ProcessDate is Null 
	Order by BirthDate desc
		,CaseID


Open cImportKeys

Fetch Next From cImportKeys into @pkCPImportEISCase
Set @lf = @@Fetch_Status

While @lf = 0
begin
	select 
		@pkCPClient = 0
		,@pkCPClientCase = 0
		,@pkCPClientAddress = 0
		,@pkCPJoinClientClientCase = 0
		,@pkCPJoinClientClientAddress = 0
		,@pkCPClientPhone = 0
		,@pkCPJoinClientClientPhone = 0
		,@SSN = Null

	Select 	
		@CaseNum = CaseID
		,@LocalCaseNum = CountyCaseNum
		--,@WorkerNum = WorkerNumber		
		,@DistrictNo = DistrctNo
		,@chFirstName = FirstName
		,@chMiddleName = MiddleName
		,@chLastName = LastName
		,@Street1 = Street1
		,@Street2 = Street2
		,@City = City
		,@State = [State]
		,@Zip = Zip
		,@ZipPlusFour = ZipPlus4
		,@chID = IndividualID
		,@Sex = Sex
		,@Phone = Phone
		,@BirthDate = BirthDate
	From	CPImportEISCase with (nolock)
	Where	pkCPImportEISCase = @pkCPImportEISCase

	Set @bCaseHeadPreviouslyProcessed = 1
-- did this person already process today?
	if not exists (Select * From CPImportEISIndividual with (nolock)
					Where IndividualID = @chID
					And	fkCPImportBatch = @pkCPImportBatch 
					And ProcessDate is not null)
		And not exists (Select * From CPImportEISCase with (nolock)
					Where IndividualID = @chID
					And	fkCPImportBatch = @pkCPImportBatch 
					And ProcessDate is not null) 
		And not exists (Select * From CPImportFSIS with (nolock)
					Where (CaseHeadIndividualID = @chID
						Or ParticipantIndividualID = @chID)
					And	fkCPImportBatch = @pkCPImportBatch 
					And ProcessDate is not null) Begin
		Set @bCaseHeadPreviouslyProcessed = 0
		end

	/* Add/Update Case Information including Case Head Information*/
	select @SSN = SSNFormatted
	from dbo.CPImportEISIndividual with (nolock)
	where fkCPImportBatch = @pkCPImportBatch
	--and CaseID = @CaseNum
	and IndividualID = @chID
	Order by SSNFormatted desc

	select @SSN = isnull(@SSN,'000000000')
	
	Exec spCPImportCPClientV2	
		@FirstName = @chFirstName
		,@LastName = @chLastName
		,@MiddleName = @chMiddleName
		,@SSN = @SSN
		,@BirthDate = @BirthDate
		,@StateIssuedNumber = @chID
		,@Sex = @Sex
		,@HomePhone = @Phone
		,@bClientPreviouslyUpdated = @bCaseHeadPreviouslyProcessed
		,@pkCPClient = @pkCPClientCaseHead Output
		,@pkCPRefImportLogEventType = @ImportLogEventType Output	 -- Move Logging to SP

	Exec spCPImportCPClientCaseV2	
		@StateCaseNumber = @CaseNum
		,@LocalCaseNumber = @LocalCaseNum
		,@CaseWorkerCode = @DistrictNo
		,@pkCPRefClientCaseProgramType = @pkProgramType --EIS
		,@fkCPClientCaseHead = @pkCPClientCaseHead
		,@pkrefClientCaseImportSource = 2
		,@pkCPClientCase = @pkCPClientCase Output
		,@pkCPRefImportLogEventType = @ImportLogEventType Output	-- Move Logging to SP

	-- Remove this when People is able to handle case heads that are not participants
	Exec spCPImportCPJoinClientClientCaseV2	
		@fkCPClient = @pkCPClientCaseHead
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

 -- did this person already process today?
	if  @bCaseHeadPreviouslyProcessed = 0 Begin
		Exec spCPImportCPJoinClientClientAddressV2	
			@fkCPClient = @pkCPClientCaseHead
			,@fkCPClientAddress = @pkCPClientAddress
			,@fkCPRefAddressType = 1
			,@pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress Output
			,@pkCPRefImportLogEventType = @ImportLogEventType Output		
	end 

	Declare cIn INSENSITIVE Cursor  For
	Select pkCPImportEISIndividual 
	From CPImportEISIndividual with (nolock)
	Where CaseID = @CaseNum 
	and ProcessDate is Null
	and fkCPImportBatch = @pkCPImportBatch 
	Order by IndividualID

	Open cIn
	
	Fetch Next From cIn Into @pkCPImportEISIndividual
	Set @lf2 = @@Fetch_Status

	While @lf2 = 0 
	begin
		select @pkCPClient = 0
			,@pkCPJoinClientClientCase = 0
			,@pkCPJoinClientClientAddress = 0
			,@pkCPJoinClientClientPhone = 0

		/* Get the individual information for this case */
		Select 	
			@inFirstName = FirstName
			,@inMiddleName = MiddleName
			,@inLastName = LastName
			,@BirthDate = BirthDate
			,@inID = IndividualID
			,@SSN = SSNFormatted
			,@Sex = Sex
		From	CPImportEISIndividual with (nolock)
		Where	pkCPImportEISIndividual = @pkCPImportEISIndividual

		if @chID <> @inID begin -- If the Case Head, we already did this above
			Set @bIndividualPreviouslyProcessed = 1
				-- did this person already process today?
				if not exists (Select * From CPImportEISIndividual with (nolock)
								Where IndividualID = @inID
								And	fkCPImportBatch = @pkCPImportBatch 
								And ProcessDate is not null)
					And not exists (Select * From CPImportEISCase with (nolock)
								Where IndividualID = @inID
								And	fkCPImportBatch = @pkCPImportBatch 
								And ProcessDate is not null)
					And not exists (Select * From CPImportFSIS with (nolock)
								Where (CaseHeadIndividualID = @inID
									Or ParticipantIndividualID = @inID)
								And	fkCPImportBatch = @pkCPImportBatch 
								And ProcessDate is not null) Begin
					Set @bIndividualPreviouslyProcessed = 0
			End
			Exec spCPImportCPClientV2	
				@FirstName = @inFirstName
				,@LastName = @inLastName
				,@MiddleName = @inMiddleName
				,@SSN = @SSN
				,@BirthDate = @BirthDate
				,@StateIssuedNumber = @inID
				,@Sex = @Sex
				,@HomePhone = @Phone
				,@bCLientPreviouslyUpdated = @bIndividualPreviouslyProcessed
				,@pkCPClient = @pkCPClient Output
				,@pkCPRefImportLogEventType = @ImportLogEventType Output	 -- Move Logging to SP

			Exec spCPImportCPJoinClientClientCaseV2	
				@fkCPClient = @pkCPClient
				,@fkCPClientCase = @pkCPClientCase
				,@PrimaryParticipantOnCase = 0
				,@pkCPJoinClientClientCase = @pkCPJoinClientClientCase Output
				,@pkCPRefImportLogEventType = @ImportLogEventType Output		-- Move Logging to SP

			-- did this person already process today?
			if  @bIndividualPreviouslyProcessed = 0 Begin

					Exec spCPImportCPJoinClientClientAddressV2	
						@fkCPClient = @pkCPClient
						,@fkCPClientAddress = @pkCPClientAddress
						,@fkCPRefAddressType = 1
						,@pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress Output
						,@pkCPRefImportLogEventType = @ImportLogEventType Output

			end
		
		end else begin
			select @pkCPClient = @pkCPClientCaseHead
		end

		Update CPImportEISIndividual Set ProcessDate = GetDate() Where pkCPImportEISIndividual = @pkCPImportEISIndividual

		Fetch Next From cIn Into @pkCPImportEISIndividual
		Set @lf2 = @@Fetch_Status
	end

	Close cIn
	Deallocate cIn

	Update CPImportEISCase Set ProcessDate = GetDate() Where pkCPImportEISCase = @pkCPImportEISCase
	
	Fetch next From cImportKeys Into @pkCPImportEISCase
	Set @lf = @@Fetch_Status
end

Close cImportKeys
Deallocate cImportKeys

/* Now we should have all of the case head information, we need to add our stragglers from the inidvidual table */
Declare cIn INSENSITIVE Cursor For
Select pkCPImportEISIndividual 
From CPImportEISIndividual with (nolock)
Where fkCPImportBatch = @pkCPImportBatch 
and ProcessDate is null 

Open cIn

Fetch Next from cIn Into @pkCPImportEISIndividual
Set @lf2 = @@Fetch_Status

While @lf2 = 0
begin
	select 
		@pkCPClient = 0
		,@pkCPClientCase = 0
		,@pkCPClientAddress = 0
		,@pkCPJoinClientClientCase = 0
		,@pkCPJoinClientClientAddress = 0

	Select 	
		@inFirstName = FirstName
		,@inMiddleName = MiddleName
		,@inLastName = LastName
		,@BirthDate = BirthDate
		,@inID = IndividualID
		,@SSN = SSNFormatted
		,@CaseNum = CaseID
		,@Sex = Sex
	From	CPImportEISIndividual with (nolock)
	Where	pkCPImportEISIndividual = @pkCPImportEISIndividual

	-- See if case exists already in the system
	Select @pkCPClientCase = pkCPClientCase
	from CPClientCase with (nolock)
	where StateCaseNumber = @CaseNum
	
	if @pkCPClientCase = 0 begin
		Exec spCPImportCPClientCaseV2	
			@StateCaseNumber = @CaseNum
			,@LocalCaseNumber = ''
			,@CaseWorkerCode = null
			,@pkCPRefClientCaseProgramType = 2 --EIS
			,@pkrefClientCaseImportSource = 2
			,@pkCPClientCase = @pkCPClientCase Output
			,@pkCPRefImportLogEventType = @ImportLogEventType Output
	end
	Set @bIndividualPreviouslyProcessed = 1
		-- did this person already process today?
		if not exists (Select * From CPImportEISIndividual with (nolock)
						Where IndividualID = @inID
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null)
			And not exists (Select * From CPImportEISCase with (nolock)
						Where IndividualID = @inID
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null)
			And not exists (Select * From CPImportFSIS with (nolock)
						Where (CaseHeadIndividualID = @inID
							Or ParticipantIndividualID = @inID)
						And	fkCPImportBatch = @pkCPImportBatch 
						And ProcessDate is not null) Begin
			Set @bIndividualPreviouslyProcessed = 0
	End
	Exec spCPImportCPClientV2	
		@FirstName = @inFirstName
		,@LastName = @inLastName
		,@MiddleName = @inMiddleName
		,@SSN = @SSN
		,@BirthDate = @BirthDate
		,@StateIssuedNumber = @inID
		,@Sex = @Sex
		,@bClientPreviouslyUpdated = @bIndividualPreviouslyProcessed
		,@pkCPClient = @pkCPClient Output
		,@pkCPRefImportLogEventType = @ImportLogEventType Output	 -- Move Logging to SP

	Exec spCPImportCPJoinClientClientCaseV2	
		@fkCPClient = @pkCPClient
		,@fkCPClientCase = @pkCPClientCase
		,@PrimaryParticipantOnCase = 0
		,@IgnorePrimaryParticipantOnCase = 1
		,@pkCPJoinClientClientCase = @pkCPJoinClientClientCase Output
		,@pkCPRefImportLogEventType = @ImportLogEventType Output

	Update CPImportEISIndividual Set ProcessDate = GetDate() Where pkCPImportEISIndividual = @pkCPImportEISIndividual

	Fetch Next from cIn Into @pkCPImportEISIndividual
	Set @lf2 = @@Fetch_Status
end

Close cIn
Deallocate cIn


-- Remove clients from cases that have not been part of that case for some time

--if 1 = 2 begin
--	select @EffectiveDate = max(EffectiveDate)
--	from dbo.CPImportEISCase with (nolock)
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
--					from CPImportEISCase ic with (nolock)
--					where ic.fkCPImportBatch = @pkCPImportBatch
--					)
--	and j.PrimaryParticipantOnCase <> 1


--	Declare cDelete INSENSITIVE Cursor For
--		select 
--			pkCPJoinClientClientCase
--			,EffectiveDateOfDelete = max(i.EffectiveDate)
--		from #Intermediate j
--		inner join dbo.CPImportEISIndividual i with (nolock) on i.CaseID = j.StateCaseNumber
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
--						and datediff(day,CreateDate,getdate()) <= abs(dbo.RecentDaysConstant())
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










