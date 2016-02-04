

CREATE Proc [dbo].[spCPImportCPJoinClientClientPhoneV2] (
	@fkCPClient decimal (18,0)
	,@fkCPClientPhone decimal (18,0)
	,@fkCPRefPhoneType decimal (18,0)
	,@EffectiveDate datetime = null -- 12/2011 Not used, but left in for compatability
	,@pkCPJoinClientClientPhone numeric (18,0) Output
)
as

declare 
	@HostName varchar(100)
	,@fkCPClientPhoneCurrent decimal
	,@pkCPImportLog decimal
	,@lf int
	,@pkCPJoinClientClientPhoneToDelete decimal

select @HostName = host_name()

set @pkCPJoinClientClientPhone = 0

select @pkCPJoinClientClientPhone = jp.pkCPJoinClientClientPhone
	,@fkCPClientPhoneCurrent = fkCPClientPhone
From CPJoinClientClientPhone jp with (nolock)
inner Join CPClientPhone p with (nolock) on jp.fkCPClientPhone = p.pkCPClientPhone
Where jp.fkCPClient = @fkCPClient
and p.fkCPRefPhoneType = @fkCPRefPhoneType

if @pkCPJoinClientClientPhone <> 0 begin
	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 19
		,@fkCPJoinClientClientPhone = @pkCPJoinClientClientPhone


	if @fkCPClientPhone = 0 begin	-- No longer has that type of phone
		exec dbo.uspCPJoinClientClientPhoneDelete
			@pkCPJoinClientClientPhone = @pkCPJoinClientClientPhone
			, @LUPUser = @HostName
			, @LUPMac = @HostName
			, @LUPIP = @HostName
			, @LUPMachine = @HostName

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 21
			,@fkCPJoinClientClientPhone = @pkCPJoinClientClientPhone

	end else begin
		if @fkCPClientPhoneCurrent <> @fkCPClientPhone 
		begin
			exec dbo.uspCPJoinClientClientPhoneUpdate
				@pkCPJoinClientClientPhone = @pkCPJoinClientClientPhone
				, @fkCPClient = @fkCPClient
				, @fkCPClientPhone = @fkCPClientPhone
				, @fkCPRefPhoneType = @fkCPRefPhoneType
				, @LUPUser = @HostName
				, @LUPMac = @HostName
				, @LUPIP = @HostName
				, @LUPMachine = @HostName

			exec dbo.spCPInsertCPImportLog
				@pkCPImportLog = @pkCPImportLog Output
				,@fkCPRefImportLogEventType = 20
				,@fkCPJoinClientClientPhone = @pkCPJoinClientClientPhone

		end

	end

end else begin
	exec dbo.uspCPJoinClientClientPhoneInsert
		  @fkCPClient = @fkCPClient
		, @fkCPClientPhone = @fkCPClientPhone
		, @fkCPRefPhoneType = @fkCPRefPhoneType
		, @LUPUser = @HostName
		, @LUPMac = @HostName
		, @LUPIP = @HostName
		, @LUPMachine = @HostName
		, @pkCPJoinClientClientPhone = @pkCPJoinClientClientPhone output

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 18
		,@fkCPJoinClientClientPhone = @pkCPJoinClientClientPhone


end



