CREATE proc [dbo].[JoinExternalTaskMetaDataCPClientSave]
	@fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinExternalTaskMetaDataCPClient decimal(18, 0) = null output
as

set @pkJoinExternalTaskMetaDataCPClient = null

select	@pkJoinExternalTaskMetaDataCPClient = pkJoinExternalTaskMetaDataCPClient
from	JoinExternalTaskMetaDataCPClient
where	fkExternalTaskMetaData = @fkExternalTaskMetaData
and		fkCPClient = @fkCPClient
	
if @pkJoinExternalTaskMetaDataCPClient is null
	begin
	exec dbo.uspJoinExternalTaskMetaDataCPClientInsert
		@fkExternalTaskMetaData = @fkExternalTaskMetaData
		,@fkCPClient = @fkCPClient
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
		,@pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient output
	end
else
	begin
	exec dbo.uspJoinExternalTaskMetaDataCPClientUpdate
		@pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient
		,@fkExternalTaskMetaData = @fkExternalTaskMetaData
		,@fkCPClient = @fkCPClient
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end
