CREATE proc [dbo].[JoinExternalTaskMetaDataCPClientCaseRemove]
	@fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
as

declare @pkJoinExternalTaskMetaDataCPClientCase decimal

select	@pkJoinExternalTaskMetaDataCPClientCase = pkJoinExternalTaskMetaDataCPClientCase
from	JoinExternalTaskMetaDataCPClientCase
where	fkExternalTaskMetaData = @fkExternalTaskMetaData
and		fkCPClientCase = @fkCPClientCase
	
if @pkJoinExternalTaskMetaDataCPClientCase is not null
	begin
	exec dbo.uspJoinExternalTaskMetaDataCPClientCaseDelete
		@pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end

