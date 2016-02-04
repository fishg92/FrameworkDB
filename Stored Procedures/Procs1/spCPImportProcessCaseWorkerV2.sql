-- Stored Procedure

CREATE Proc [dbo].[spCPImportProcessCaseWorkerV2] (
	@pkCPImportBatch int
)
as


Declare 
	@HostName varchar(100)
	,@workerId1 varchar(10)
	,@workerId2 varchar(10)
	,@workerId3 varchar(10)
	,@workerId4 varchar(10)
	,@workerId5 varchar(10)
	,@workerId6 varchar(10)
	,@workerId7 varchar(10)
	,@workerId8 varchar(10)
	,@workerId9 varchar(10)
	,@workerId10 varchar(10)
	,@pkApplicationUser decimal (18,0)
	,@UserName varchar (50)
	,@PhoneNumber varchar(30)
	,@Extension varchar(50)
	,@StateID varchar(10)
	,@DistrictID varchar(10)
	,@ImportCreateUser varchar(50)
	,@pkCPImportCaseWorker decimal
	,@lf int
	,@cursorStatus int
	,@pkCpCaseWorkerAltId decimal (18,0)
	,@pkCPCaseWorkerPhone decimal (18,0)
	,@pkCPJoinCaseWorkerCaseWorkerPhone decimal (18,0)




select @HostName = host_name()


select @ImportCreateUser = CreateUser 
From CPImportBatch with (nolock)
where pkCPImportBatch = @pkCPImportBatch

Declare cImportKeys Cursor For
Select pkCPImportCaseWorker 
From CPImportCaseWorker with (nolock)
Where fkCPImportBatch = @pkCPImportBatch 
And ltrim(rtrim(isnull(DistrictId,''))) <> ''

Open cImportKeys

Fetch Next From cImportKeys into @pkCPImportCaseWorker
Set @lf = @@Fetch_Status

While @lf = 0
begin

	Select 
		@StateID = case when isnumeric(DistrictID) = 1 then convert(varchar(50),convert(decimal(18,0),DistrictID))
							else DistrictID
					   end
		,@UserName = UserName
		,@PhoneNumber = replace(PhoneNumber,'-','')
		,@Extension = Extension
		,@districtId = districtId
		,@workerId1 = workerId1
		,@workerId2 = workerId2
		,@workerId3 = workerId3
		,@workerId4 = workerId4
		,@workerId5 = workerId5
		,@workerId6 = workerId6
		,@workerId7 = workerId7
		,@workerId8 = workerId8
		,@workerId9 = workerId9
		,@workerId10 = workerId10
		,@UserName =  Username
	From	CPImportCaseWorker with (nolock)
	Where	pkCPImportCaseWorker = @pkCPImportCaseWorker

	Set @pkApplicationUser = (select dbo.fnGetApplicationUserFromUserName(@UserName))




	If @pkApplicationUser > 0 
	begin


			--Update Phone Number

			If LTRim(RTrim(isnull(@PhoneNumber,''))) <> ''
			Begin
				exec uspApplicationUserUpdate 
					@pkApplicationUser = @pkApplicationUser
					,@PhoneNumber = @PhoneNumber
					, @LUPUser = @HostName
					, @LUPMac = @HostName
					, @LUPIP = @HostName
					, @LUPMachine = @HostName
			End

			--Update Extension

			If LTRim(RTrim(isnull(@Extension,''))) <> ''
			Begin
				exec uspApplicationUserUpdate 
					@pkApplicationUser = @pkApplicationUser
					,@Extension = @Extension
					, @LUPUser = @HostName
					, @LUPMac = @HostName
					, @LUPIP = @HostName
					, @LUPMachine = @HostName
			End

			-- Update StateID field

			If LTRim(RTrim(isnull(@StateID,''))) <> ''
			Begin
				exec uspApplicationUserUpdate 
					@pkApplicationUser = @pkApplicationUser
					,@StateID = @StateID
					, @LUPUser = @HostName
					, @LUPMac = @HostName
					, @LUPIP = @HostName
					, @LUPMachine = @HostName
			End

			If LTRim(RTrim(isnull(@workerId1,''))) <> ''
			Begin 
				set @workerId1 = LTRim(RTrim(@workerId1))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId1
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId2,''))) <> ''
			Begin 
				Set @workerId2 = LTRim(RTrim(@workerId2))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId2
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId3,''))) <> ''
			Begin 
				Set @workerId3 = LTRim(RTrim(@workerId3))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId3
					,@fkApplicationUser = @pkApplicationUser
			End
			If LTRim(RTrim(isnull(@workerId4,''))) <> ''
			Begin 
				Set @workerId4 = LTRim(RTrim(@workerId4))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId4
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId5,''))) <> ''
			Begin 
				Set @workerId5 = LTRim(RTrim(@workerId5))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId5
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId6,''))) <> ''
			Begin 
				Set @workerId6 = LTRim(RTrim(@workerId6))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId6
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId7,''))) <> ''
			Begin 
				Set @workerId7 = LTRim(RTrim(@workerId7))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId7
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId8,''))) <> ''
			Begin 
				Set @workerId8 = LTRim(RTrim(@workerId8))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId8
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId9,''))) <> ''
			Begin 
				Set @workerId9 = LTRim(RTrim(@workerId9))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId9
					,@fkApplicationUser = @pkApplicationUser 
			End
			If LTRim(RTrim(isnull(@workerId10,''))) <> ''
			Begin 
				Set @workerId10 = LTRim(RTrim(@workerId10))
				Exec spCPImportCPCaseWorkerAltIdsV2	
					@workerId = @workerId10
					,@fkApplicationUser = @pkApplicationUser
			End

			Declare cDeletedWorkers Cursor For
				Select pkCpCaseWorkerAltId
				From CpCaseWorkerAltId 
				Where fkApplicationUser = @pkApplicationUser
				And (workerId <>  @workerId1 
				And workerId <>  @workerId2
				And workerId <>  @workerId3
				And workerId <>  @workerId4
				And workerId <>  @workerId5
				And workerId <>  @workerId6
				And workerId <>  @workerId7
				And workerId <>  @workerId8
				And workerId <>  @workerId9
				And workerId <>  @workerId10)

			Open cDeletedWorkers

			Fetch Next From cDeletedWorkers into @pkCpCaseWorkerAltId
			Set @CursorStatus = @@Fetch_Status

			While @CursorStatus = 0
				begin
						Exec uspCpCaseWorkerAltIdDelete	
							@pkCPCaseWorkerAltId = @pkCpCaseWorkerAltId
							, @LUPUser = @HostName
							, @LUPMac = @HostName
							, @LUPIP = @HostName
							, @LUPMachine = @HostName

					Fetch Next From cDeletedWorkers into @pkCpCaseWorkerAltId
					Set @CursorStatus = @@Fetch_Status
				end
			close cDeletedWorkers
			Deallocate cDeletedWorkers

			Update CPImportCaseWorker Set ProcessDate = GetDate() where pkCPImportCaseWorker = @pkCPImportCaseWorker
	end


	Fetch Next From cImportKeys into @pkCPImportCaseWorker
	Set @lf = @@Fetch_Status
end

close cImportKeys
Deallocate cImportKeys
