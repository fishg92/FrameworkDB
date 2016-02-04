
CREATE proc [dbo].[ProcessCPUpdatePhone]
	@pkCPClient decimal
	,@phoneNum varchar(20)
	,@phoneExt varchar(20)
	,@fkCPRefPhoneType decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	
as
if ltrim(@phoneNum) = ''
	set @phoneNum = null
	
if @phoneNum is not null
	begin
	set @phoneNum = dbo.StripPhone(@phoneNum)

	if @fkCPRefPhoneType <> 2 BEGIN
		set @phoneExt = ''
	end else BEGIN
		set @phoneExt =  dbo.StripPhone(@phoneExt)
	END 

	declare @pkCPClientPhone decimal
	
	select @pkCPClientPhone = CPClientPhone.pkCPClientPhone
	from	CPClientPhone
	join CPJoinClientClientPhone
		on CPClientPhone.pkCPClientPhone = CPJoinClientClientPhone.fkCPClientPhone
	where CPJoinClientClientPhone.fkCPClient = @pkCPClient
	and CPJoinClientClientPhone.fkCPRefPhoneType = @fkCPRefPhoneType


	if @pkCPClientPhone is null
		begin
		delete	CPJoinClientClientPhone
		where	fkCPClient = @pkCPClient
		and		fkCPRefPhoneType = @fkCPRefPhoneType

		exec dbo.uspCPClientPhoneInsert
			@fkCPRefPhoneType = @fkCPRefPhoneType
			, @Number = @phoneNum
			, @Extension = @phoneExt
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
			, @pkCPClientPhone = @pkCPClientPhone output
		
		exec dbo.uspCPJoinClientClientPhoneInsert
			@fkCPClient = @pkCPClient
			, @fkCPClientPhone = @pkCPClientPhone
			, @fkCPRefPhoneType = @fkCPRefPhoneType
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		
		end
	else
		begin

		exec dbo.uspCPClientPhoneUpdate
			@pkCPClientPhone = @pkCPClientPhone
			, @fkCPRefPhoneType = @fkCPRefPhoneType
			, @Number = @phoneNum
			, @Extension = @phoneExt
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		end
	
	end
