CREATE proc [dbo].[JoinExternalTaskMetaDataCPClientRemove]
	@fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
as

declare @pkJoinExternalTaskMetaDataCPClient decimal

select	@pkJoinExternalTaskMetaDataCPClient = pkJoinExternalTaskMetaDataCPClient
from	JoinExternalTaskMetaDataCPClient
where	fkExternalTaskMetaData = @fkExternalTaskMetaData
and		fkCPClient = @fkCPClient
	
if @pkJoinExternalTaskMetaDataCPClient is not null
	begin
	exec dbo.uspJoinExternalTaskMetaDataCPClientDelete
		@pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end

