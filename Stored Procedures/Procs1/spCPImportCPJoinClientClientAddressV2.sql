


CREATE  Proc [dbo].[spCPImportCPJoinClientClientAddressV2] (
	@fkCPClient decimal (18,0)
	,@fkCPClientAddress decimal (18,0)
	,@fkCPRefAddressType decimal (18,0)
	,@EffectiveDate datetime = null -- not used but left for compatability
	,@pkCPJoinClientClientAddress numeric (18,0) Output
	,@pkCPRefImportLogEventType decimal (18,0) = Null Output
)
as

declare
	@HostName varchar(100)
	,@fkCPClientAddressCurrent decimal
	,@pkCPImportLog decimal
	,@lf int
	,@pkCPJoinClientClientAddressToDelete decimal

select @HostName = host_name()

set @pkCPJoinClientClientAddress = 0

select @pkCPJoinClientClientAddress = j.pkCPJoinClientClientAddress
	,@fkCPClientAddressCurrent = j.fkCPClientAddress
from CPJoinClientClientAddress j with (nolock)
inner join CPClientAddress a with (nolock) on a.pkCPClientAddress = j.fkCPClientAddress
where j.fkCPClient = @fkCPClient
and a.fkCPRefClientAddressType = @fkCPRefAddressType

if @pkCPJoinClientClientAddress <> 0 begin
	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 16
		,@fkCPJoinClientClientAddress = @pkCPJoinClientClientAddress

	if @fkCPClientAddress = 0 begin		-- No longer has this type of address
		exec dbo.uspCPJoinClientClientAddressDelete
			@pkCPJoinClientClientAddress=@pkCPJoinClientClientAddress
			, @LUPUser=@HostName
			, @LUPMac=@HostName
			, @LUPIP=@HostName
			, @LUPMachine=@HostName

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 11
			,@fkCPJoinClientClientAddress = @pkCPJoinClientClientAddress

	end else begin
		if @fkCPClientAddressCurrent <> @fkCPClientAddress 
		begin
			exec dbo.uspCPJoinClientClientAddressUpdate
				@pkCPJoinClientClientAddress=@pkCPJoinClientClientAddress
				, @fkCPClient=@fkCPClient
				, @fkCPClientAddress=@fkCPClientAddress
				, @fkCPRefClientAddressType = @fkCPRefAddressType
				, @LUPUser=@HostName
				, @LUPMac=@HostName
				, @LUPIP=@HostName
				, @LUPMachine=@HostName

			exec dbo.spCPInsertCPImportLog
				@pkCPImportLog = @pkCPImportLog Output
				,@fkCPRefImportLogEventType = 17
				,@fkCPJoinClientClientAddress = @pkCPJoinClientClientAddress

		end
	end
end else begin
	exec dbo.uspCPJoinClientClientAddressInsert
		  @fkCPClient=@fkCPClient
		, @fkCPClientAddress=@fkCPClientAddress
		, @fkCPRefClientAddressType = @fkCPRefAddressType
		, @LUPUser=@HostName
		, @LUPMac=@HostName
		, @LUPIP=@HostName
		, @LUPMachine=@HostName
		, @pkCPJoinClientClientAddress=@pkCPJoinClientClientAddress output

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 15
		,@fkCPJoinClientClientAddress = @pkCPJoinClientClientAddress

end


