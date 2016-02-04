
CREATE proc [dbo].[ProcessCPUpdate]
	@FirstName varchar(50)
	,@LastName varchar(50)
	,@MiddleName varchar(50) = null
	,@NameSuffix varchar(20) = null
	,@Sex char(1) = null
	,@BirthDate datetime = null
	,@SSN varchar(10)
	
	,@ExternalSystemName varchar(50) = null
	,@ExternalSystemID varchar(50) = null
	
	,@pkProgramType decimal = null
	,@CaseNumber varchar(20) = null

	,@mailStreet1 varchar(100) = null
	,@mailStreet2 varchar(100) = null
	,@mailCity varchar(100) = null
	,@mailState char(2) = null
	,@mailZip varchar(10) = null
	,@mailZipPlus4 varchar(4) = null
	
	,@resStreet1 varchar(100) = null
	,@resStreet2 varchar(100) = null
	,@resCity varchar(100) = null
	,@resState char(2) = null
	,@resZip varchar(10) = null
	,@resZipPlus4 varchar(4) = null

	,@homePhone varchar(20) = null
	,@workPhone varchar(20) = null
	,@workPhoneExt varchar(10) = null
	,@cellPhone varchar(20) = null
	
	,@CompassNumber varchar(50) = null output
	,@pkCPClient decimal = null output
	
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)

	
as
if ltrim(@MiddleName) = ''
	set @MiddleName = null

if ltrim(@NameSuffix) = ''
	set @NameSuffix = null

if ltrim(@Sex) = ''
	set @Sex = null
else
	set @Sex = upper(@Sex)
	
if @pkProgramType < 1
	set @pkProgramType = null

set @CaseNumber = ltrim(rtrim(@CaseNumber))
if @CaseNumber = ''
	set @CaseNumber = null
	
if @ExternalSystemName = ''
or @ExternalSystemID = ''
	begin
	set @ExternalSystemName = null
	set @ExternalSystemID = null
	end	

		
declare @pkMailAddress decimal
		,@pkResAddress decimal
		,@pkCPClientCase decimal
		,@pkCPClientAddress decimal
		,@NorthwoodsNumber varchar(50)
		,@pkCPClientExternalID decimal
		
		

set @pkCPClient = dbo.fnProcessCPUpdateFindClient 
					(@FirstName
					,@LastName
					,@MiddleName
					,@SSN
					,@BirthDate
					,@Sex
					,@ExternalSystemName
					,@ExternalSystemID)
			
set @BirthDate = isnull(@BirthDate,'1/1/1900')		


if @pkCPClient = 0
	begin
	exec dbo.uspCPClientInsert
		@LastName = @LastName
		, @FirstName = @FirstName
		, @MiddleName = @MiddleName
		, @Suffix = @NameSuffix
		, @SSN = @SSN
		, @NorthwoodsNumber = @NorthwoodsNumber output
		, @StateIssuedNumber = ''
		, @BirthDate = @BirthDate
		, @BirthLocation = ''
		, @Sex = @Sex
		, @fkCPRefClientEducationType = null
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
		, @pkCPClient = @pkCPClient output
	
	end
else
	begin

	/* per Randy and QA, don't overwrite Pilot SSN with external blank */
	if ltrim(rtrim(@SSN)) = '' BEGIN
		set @SSN = null
	END

	exec dbo.uspCPClientUpdate
		@pkCPClient = @pkCPClient
		, @LastName = @LastName
		, @FirstName = @FirstName
		, @MiddleName = @MiddleName
		, @Suffix = @NameSuffix
		, @SSN = @SSN
		, @NorthwoodsNumber = @NorthwoodsNumber output
		, @StateIssuedNumber = null
		, @BirthDate = @BirthDate
		, @BirthLocation = null
		, @Sex = @Sex
		, @fkCPRefClientEducationType = null
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end	

if @ExternalSystemName is not null
and @ExternalSystemID is not null
	begin
	set @pkCPClientExternalID = null
	
	select @pkCPClientExternalID = pkCPClientExternalID	
	from CPClientExternalID
	where fkCPClient = @pkCPClient
	and ExternalSystemName = @ExternalSystemName
	
	if @pkCPClientExternalID is null
		begin
		exec dbo.uspCPClientExternalIDInsert
			@fkCPClient = @pkCPClient
			, @ExternalSystemName = @ExternalSystemName
			, @ExternalSystemID = @ExternalSystemID
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		end
	else
		begin
		exec dbo.uspCPClientExternalIDUpdate
			@pkCPClientExternalID = @pkCPClientExternalID
			,@fkCPClient = @pkCPClient
			,@ExternalSystemName = @ExternalSystemName
			,@ExternalSystemID = @ExternalSystemID
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		end	
	end	

if @pkProgramType is not null
and exists (select	*
			from	ProgramType 
			where	pkProgramType = @pkProgramType)
			and @CaseNumber is not null			
	BEGIN


		/** If we find an existing case number for this client but the program
			type has changed, update the program type **/
		set @pkCPClientCase = null
		
		set @pkCPClientCase = (select top 1 CPClientCase.pkCPClientCase
								from	CPClientCase
								join	CPJoinClientClientCase
									on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
								where CPClientCase.StateCaseNumber = @CaseNumber
								and CPJoinClientClientCase.fkCPClient = @pkCPClient
								and CPClientCase.fkCPRefClientCaseProgramType <> @pkProgramType)
		if @pkCPClientCase is not null
			BEGIN
				exec dbo.uspCPClientCaseUpdate
					@pkCPClientCase = @pkCPClientCase
					, @fkCPRefClientCaseProgramType = @pkProgramType
					, @LUPUser = @LUPUser
					, @LUPMac = @LUPMac
					, @LUPIP = @LUPIP
					, @LUPMachine = @LUPMachine
			END



		set @pkCPClientCase = null
		
		select @pkCPClientCase = pkCPClientCase
		from	CPClientCase
		where	StateCaseNumber = @CaseNumber
		and		fkCPRefClientCaseProgramType = @pkProgramType
		
		if @pkCPClientCase is null
			BEGIN
				/* case doesn't exist at all, create it and the join to the client */
				exec dbo.uspCPClientCaseInsert
					@StateCaseNumber = @CaseNumber
					, @LocalCaseNumber = ''
					, @fkCPRefClientCaseProgramType = @pkProgramType
					, @fkCPCaseWorker = null
					, @LUPUser = @LUPUser
					, @LUPMac = @LUPMac
					, @LUPIP = @LUPIP
					, @LUPMachine = @LUPMachine
					, @pkCPClientCase = @pkCPClientCase output

				exec dbo.uspCPJoinClientClientCaseInsert
					@fkCPClientCase = @pkCPClientCase
					, @fkCPClient = @pkCPClient
					, @PrimaryParticipantOnCase = 0
					, @LUPUser = @LUPUser
					, @LUPMac = @LUPMac
					, @LUPIP = @LUPIP
					, @LUPMachine = @LUPMachine
			END else BEGIN
				/* case does exist, make sure we have a join to client and create it if not there */
				if not exists (select * from CPJoinClientClientCase where fkcpClient = @pkCPClient 
									and fkcpClientCase = @pkCPClientCase) 
								BEGIN
										exec dbo.uspCPJoinClientClientCaseInsert
											@fkCPClientCase = @pkCPClientCase
											, @fkCPClient = @pkCPClient
											, @PrimaryParticipantOnCase = 0
											, @LUPUser = @LUPUser
											, @LUPMac = @LUPMac
											, @LUPIP = @LUPIP
											, @LUPMachine = @LUPMachine
								END
			END
			
	end
	
/** Mailing Address **/
exec dbo.ProcessCPUpdateAddress
	@pkCPClient = @pkCPClient
	,@Street1 = @mailStreet1
	,@Street2 = @mailStreet2
	,@City = @mailCity
	,@State = @mailState
	,@Zip = @mailZip
	,@ZipPlus4 = @mailZipPlus4
	,@fkCPRefClientAddressType = 1
	, @LUPUser = @LUPUser
	, @LUPMac = @LUPMac
	, @LUPIP = @LUPIP
	, @LUPMachine = @LUPMachine

/** Residence Address **/
exec dbo.ProcessCPUpdateAddress
	@pkCPClient = @pkCPClient
	,@Street1 = @resStreet1
	,@Street2 = @resStreet2
	,@City = @resCity
	,@State = @resState
	,@Zip = @resZip
	,@ZipPlus4 = @resZipPlus4
	,@fkCPRefClientAddressType = 2
	, @LUPUser = @LUPUser
	, @LUPMac = @LUPMac
	, @LUPIP = @LUPIP
	, @LUPMachine = @LUPMachine
	
/**Home Phone**/	
exec dbo.ProcessCPUpdatePhone
	@pkCPClient = @pkCPClient
	,@phoneNum = @homePhone
	,@phoneExt = ''
	,@fkCPRefPhoneType = 1
	, @LUPUser = @LUPUser
	, @LUPMac = @LUPMac
	, @LUPIP = @LUPIP
	, @LUPMachine = @LUPMachine

/**Work Phone**/	
exec dbo.ProcessCPUpdatePhone
	@pkCPClient = @pkCPClient
	,@phoneNum = @workPhone
	,@phoneExt = @workPhoneExt
	,@fkCPRefPhoneType = 2
	, @LUPUser = @LUPUser
	, @LUPMac = @LUPMac
	, @LUPIP = @LUPIP
	, @LUPMachine = @LUPMachine

/**Cell Phone**/	
exec dbo.ProcessCPUpdatePhone
	@pkCPClient = @pkCPClient
	,@phoneNum = @cellPhone
	,@phoneExt = ''
	,@fkCPRefPhoneType = 3
	, @LUPUser = @LUPUser
	, @LUPMac = @LUPMac
	, @LUPIP = @LUPIP
	, @LUPMachine = @LUPMachine
