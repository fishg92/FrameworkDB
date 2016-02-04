










CREATE    proc [dbo].[spCPImportCPClientV2](	
	@FirstName varchar(50)
	,@LastName Varchar(50)
	,@MiddleName varchar(50)
	,@SSN varchar(10)
	,@BirthDate datetime
	,@StateIssuedNumber varchar(50)
	,@Sex char(1)
	,@HomePhone varchar (10) = ''
	,@EffectiveDate datetime = null -- Not used but left for compatability 12/2011
	,@bClientPreviouslyUpdated tinyint
	,@pkCPClient decimal (18,0) Output
	,@pkCPRefImportLogEventType decimal (18,0) = Null Output
)
as

declare
@HostName varchar(100)
, @LastNameCurrent varchar(100)
, @FirstNameCurrent varchar(100)
, @MiddleNameCurrent varchar(100)
, @SSNCurrent char(10)
, @StateIssuedNumberCurrent varchar(50)
, @BirthDateCurrent datetime
, @BirthLocationCurrent varchar(100)
, @SexCurrent char(1)
, @fkCPRefClientEducationTypeCurrent decimal
, @MaidenNameCurrent varchar(100)
, @FirstNameFormatted varchar(50)
, @LastNameFormatted varchar(50)
, @MiddleNameFormatted varchar(50)
, @StateIssuedNumberFormatted varchar(50)
, @SexFormatted char(1)
, @pkCPImportLog decimal
, @BirthDateFormatted datetime
, @SSNBest char(10)
, @BirthDateBest datetime
, @SexBest char(1)
, @HomePhoneCurrent varchar(10)

select @HostName = host_name()

select
 @FirstNameFormatted = LTRim(RTrim(isnull(@FirstName,'')))
 ,@LastNameFormatted = LTRim(RTrim(isnull(@LastName,'')))
 ,@MiddleNameFormatted = LTRim(RTrim(isnull(@MiddleName,'')))
 ,@StateIssuedNumberFormatted = LTRim(RTrim(isnull(@StateIssuedNumber,'')))
 ,@SexFormatted = isnull(@Sex,' ')
 ,@BirthDateFormatted = isnull(@BirthDate,'1/1/1900')

select @pkCPClient = 0

select @pkCPClient = [dbo].[fnCPImportFindClient](
	@FirstNameFormatted 
	,@LastNameFormatted 
	,@MiddleNameFormatted 
	,@SSN 
	,@BirthDateFormatted
	,@StateIssuedNumberFormatted 
	,@SexFormatted 
)

if @pkCPClient <> 0 begin
	
	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 3
		,@fkCPClient = @pkCPClient

	Select 	
		@LastNameCurrent=LastName
		, @FirstNameCurrent=FirstName
		, @MiddleNameCurrent=MiddleName
		, @SSNCurrent=SSN
		, @StateIssuedNumberCurrent=StateIssuedNumber
		, @BirthDateCurrent=BirthDate
		, @BirthLocationCurrent=BirthLocation
		, @SexCurrent=Sex
		, @fkCPRefClientEducationTypeCurrent=fkCPRefClientEducationType
		, @MaidenNameCurrent=MaidenName
		, @HomePhoneCurrent = HomePhone
	From	CPClient with (nolock)
	Where	pkCPClient = @pkCPClient

	if @SSN = '000000000' and @SSNCurrent <> '000000000' begin
		Set @SSNBest = @SSNCurrent
	end else if @SSN <> '000000000' and @SSNCurrent = '000000000' begin
		Set @SSNBest = @SSN
		Set @bClientPreviouslyUpdated = 0
	end else begin
		Set @SSNBest = @SSN
	end
	if @BirthDateFormatted = '1/1/1900' and isnull(@BirthDateCurrent,'1/1/1900') <> '1/1/1900' begin
		Set @BirthDateBest = @BirthDateCurrent
	end else begin
		Set @BirthDateBest = @BirthDate
	end
	If @SexFormatted = ' ' and @SexCurrent <> ' ' begin
		Set @SexBest =  @SexCurrent
	end else begin
		Set @SexBest =  @Sex
	end
	

	If @bClientPreviouslyUpdated = 0 Begin
		if RTRIM(LTRIM(isnull(@LastNameCurrent,'')))<>@LastNameFormatted
			OR RTRIM(LTRIM(isnull(@FirstNameCurrent,'')))<>@FirstNameFormatted
			OR RTRIM(LTRIM(isnull(@MiddleNameCurrent,'')))<>@MiddleNameFormatted
			OR RTRIM(LTRIM(isnull(@SSNCurrent,'000000000')))<>@SSNBest
			OR RTRIM(LTRIM(isnull(@StateIssuedNumberCurrent,'')))<>@StateIssuedNumberFormatted
			OR isnull(@BirthDateCurrent,'1/1/1900')<>@BirthDateBest
			OR isnull(@SexCurrent,' ')<>@SexBest
			OR @HomePhoneCurrent <> isnull(@HomePhone, '')
		begin
			exec dbo.uspCPClientUpdate
				@pkCPClient=@pkCPClient
				, @LastName=@LastName
				, @FirstName=@FirstName
				, @MiddleName=@MiddleName
				, @SSN=@SSNBest
				, @StateIssuedNumber=@StateIssuedNumber
				, @BirthDate=@BirthDateBest
				, @BirthLocation=@BirthLocationCurrent
				, @Sex=@SexBest
				, @fkCPRefClientEducationType=@fkCPRefClientEducationTypeCurrent
				, @MaidenName=@MaidenNameCurrent
				, @LUPUser=@HostName
				, @LUPMac=@HostName
				, @LUPIP=@HostName
				, @LUPMachine=@HostName
				, @HomePhone = @HomePhone
				, @NorthwoodsNumber = 0 -- Output variable??

			exec dbo.spCPInsertCPImportLog
				@pkCPImportLog = @pkCPImportLog Output
				,@fkCPRefImportLogEventType = 4
				,@fkCPClient = @pkCPClient
		end
	end
end else begin
	exec dbo.uspCPClientInsert
		  @LastName=@LastName
		, @FirstName=@FirstName
		, @MiddleName=@MiddleName
		, @SSN=@SSN
		, @StateIssuedNumber=@StateIssuedNumber
		, @BirthDate=@BirthDate
		, @BirthLocation=null
		, @Sex=@Sex
		, @HomePhone = @HomePhone
		, @fkCPRefClientEducationType=null
		, @MaidenName=null
		, @LUPUser=@HostName
		, @LUPMac=@HostName
		, @LUPIP=@HostName
		, @LUPMachine=@HostName
		, @pkCPClient=@pkCPClient output
		, @NorthwoodsNumber = 0 -- Output variable??

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 2
		,@fkCPClient = @pkCPClient

end











