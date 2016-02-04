

CREATE  Proc [dbo].[spCPImportCPClientCaseV2] (
	@StateCaseNumber varchar(50)
	,@LocalCaseNumber varchar(50)
	,@CaseWorkerCode varchar(20)
	,@pkCPRefClientCaseProgramType decimal (18,0)
	,@fkCPClientCaseHead decimal = null
	,@EffectiveDate datetime = null --Not used but left for compatability
	,@pkCPClientCase decimal (18,0) Output
	,@pkCPRefImportLogEventType decimal(18,0) = Null Output
	,@pkrefClientCaseImportSource decimal(18,0) = 4
)
as
declare 
		@HostName varchar(100)
		,@pkApplicationUser decimal
		,@LocalCaseNumberCurrent varchar(20)
		,@fkCPRefClientCaseProgramTypeCurrent decimal
		,@fkApplicationUserCurrent decimal
		,@fkCPClientCaseHeadCurrent decimal
		,@pkCPImportLog decimal
		,@StateCaseNumberFormatted varchar(50)
		--,@IsSanMateo bit

select @HostName = host_name()


declare @StateCaseNumberPadLength int
		,@StateCaseNumberPadCharacter varchar(1)
		,@StateCaseNumberPadPosition char(1)
		,@MatchOnLocalCaseNumber bit
		
select @StateCaseNumberPadLength = StateCaseNumberPadLength
		,@StateCaseNumberPadCharacter = StateCaseNumberPadCharacter
		,@StateCaseNumberPadPosition = StateCaseNumberPadPosition
		,@MatchOnLocalCaseNumber = MatchOnLocalCaseNumber
from refClientCaseImportSource
where pkrefClientCaseImportSource = @pkrefClientCaseImportSource

set @StateCaseNumberFormatted = @StateCaseNumber

if @StateCaseNumberPadLength > 0
and datalength(@StateCaseNumberPadCharacter) > 0
	begin
	if @StateCaseNumberPadPosition = 'L'
		set @StateCaseNumberFormatted = right(replicate(@StateCaseNumberPadCharacter,@StateCaseNumberPadLength) + @StateCaseNumber , @StateCaseNumberPadLength)
	else
		set @StateCaseNumberFormatted = left(@StateCaseNumber + replicate(@StateCaseNumberPadCharacter,@StateCaseNumberPadLength),@StateCaseNumberPadLength)
	end


--if @NomadsData = 0 
--begin
--	if @NorthCarolina = 1
--		begin
--			if @pkCPRefClientCaseProgramType = 1 begin    --FSIS
--				select @StateCaseNumberFormatted = right('00000000' + @StateCaseNumber,9)
--			end else begin	--EIS
--				select @StateCaseNumberFormatted = right('00000000' + @StateCaseNumber,8)
--			end
--		end
--	else
--		begin
--			select @StateCaseNumberFormatted = @StateCaseNumber
--					,@IsSanMateo = 1
--		end
--end
--else
--begin
--	select @StateCaseNumberFormatted = right('0000000000' + @StateCaseNumber,10)
--end

Select 	@pkApplicationUser = 0

--Select 	@pkCPCaseWorker = pkCPCaseWorker
--From 	CPCaseWorker
--Where	StateID = case when isnumeric(@CaseWorkerCode) = 1 then convert(varchar(50),convert(decimal(18,0),@CaseWorkerCode))
--						else @CaseWorkerCode
--				  end

Select @pkApplicationUser = pkApplicationUser
From 	ApplicationUser a
Left Join CpCaseWorkerAltId b on a.pkApplicationUser = b.fkApplicationUser
Where dbo.StripLeadingZeros(@CaseWorkerCode) <> '' -- Making sure that we don't match on empty strings
and (dbo.StripLeadingZeros(StateID) = dbo.StripLeadingZeros(@CaseWorkerCode)
Or dbo.StripLeadingZeros(b.WorkerId) = dbo.StripLeadingZeros(@CaseWorkerCode))

Select @pkCPClientCase = 0

if @MatchOnLocalCaseNumber = 0
	begin
		Select	@pkCPClientCase = pkCPClientCase
				,@LocalCaseNumberCurrent=LocalCaseNumber
				,@fkCPRefClientCaseProgramTypeCurrent=fkCPRefClientCaseProgramType
				,@fkApplicationUserCurrent= fkApplicationUser
				,@fkCPClientCaseHeadCurrent=fkCPClientCaseHead
		From	CPClientCase with (nolock)
		Where	StateCaseNumber = @StateCaseNumberFormatted
	end
else
	begin
		Select	@pkCPClientCase = pkCPClientCase
				,@LocalCaseNumberCurrent=LocalCaseNumber
				,@fkCPRefClientCaseProgramTypeCurrent=fkCPRefClientCaseProgramType
				,@fkApplicationUserCurrent= fkApplicationuser
				,@fkCPClientCaseHeadCurrent=fkCPClientCaseHead
		From	CPClientCase with (nolock)
		Where	StateCaseNumber = @StateCaseNumberFormatted
		and		LocalCaseNumber = @LocalCaseNumber
	end

if @pkCPClientCase <> 0 begin
	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 6
		,@fkCPClientCase = @pkCPClientCase

	If rtrim(ltrim(isnull(@LocalCaseNumberCurrent,'')))<>rtrim(ltrim(isnull(@LocalCaseNumber,'')))
		OR @fkCPRefClientCaseProgramTypeCurrent<>@pkCPRefClientCaseProgramType
		OR isnull(@fkApplicationUserCurrent,0)<>isnull(@pkApplicationUser,0)
		OR isnull(@fkCPClientCaseHeadCurrent,0)<>isnull(@fkCPClientCaseHead,0)

	begin
		exec dbo.uspCPClientCaseUpdate
			@pkCPClientCase=@pkCPClientCase
			, @StateCaseNumber=@StateCaseNumberFormatted
			, @LocalCaseNumber=@LocalCaseNumber
			, @fkCPRefClientCaseProgramType=@pkCPRefClientCaseProgramType
			, @fkApplicationUser=@pkApplicationUser
			, @fkCPClientCaseHead = @fkCPClientCaseHead
			, @LUPUser=@HostName
			, @LUPMac=@HostName
			, @LUPIP=@HostName
			, @LUPMachine=@HostName

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 7
			,@fkCPClientCase = @pkCPClientCase

	end

end else begin 
	exec dbo.uspCPClientCaseInsert
			 @StateCaseNumber=@StateCaseNumberFormatted
			, @LocalCaseNumber=@LocalCaseNumber
			, @fkCPRefClientCaseProgramType=@pkCPRefClientCaseProgramType
			, @fkApplicationUser=@pkApplicationUser
			, @fkCPClientCaseHead = @fkCPClientCaseHead
			, @LUPUser=@HostName
			, @LUPMac=@HostName
			, @LUPIP=@HostName
			, @LUPMachine=@HostName
			, @pkCPClientCase = @pkCPClientCase output

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 5
		,@fkCPClientCase = @pkCPClientCase

end


