CREATE proc [dbo].[JoinExternalTaskMetaDataCPClientCaseSave]
	@fkExternalTaskMetaData decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinExternalTaskMetaDataCPClientCase decimal(18, 0) = null output
as

set @pkJoinExternalTaskMetaDataCPClientCase = null

select	@pkJoinExternalTaskMetaDataCPClientCase = pkJoinExternalTaskMetaDataCPClientCase
from	JoinExternalTaskMetaDataCPClientCase
where	fkExternalTaskMetaData = @fkExternalTaskMetaData
and		fkCPClientCase = @fkCPClientCase
	
if @pkJoinExternalTaskMetaDataCPClientCase is null
	begin
	exec dbo.uspJoinExternalTaskMetaDataCPClientCaseInsert
		@fkExternalTaskMetaData = @fkExternalTaskMetaData
		,@fkCPClientCase = @fkCPClientCase
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
		,@pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase output
	end
else
	begin
	exec dbo.uspJoinExternalTaskMetaDataCPClientCaseUpdate
		@pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase
		,@fkExternalTaskMetaData = @fkExternalTaskMetaData
		,@fkCPClientCase = @fkCPClientCase
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end
