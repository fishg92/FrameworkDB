
CREATE proc [dbo].[ProcessCPUpdateAddress]
	@pkCPClient decimal
	,@Street1 varchar(100)
	,@Street2 varchar(100)
	,@City varchar(100)
	,@State char(2)
	,@Zip varchar(10)
	,@ZipPlus4 varchar(4)
	,@fkCPRefClientAddressType decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	
as
declare @pkCPClientAddress decimal

exec dbo.SplitZipCode
	@inputZip = @Zip
	,@inputPlus4 = @ZipPlus4
	,@outputZip = @Zip output
	,@outputPlus4 = @ZipPlus4 output

/* per qa, Pilot address data being erased, changing condition to only update if key address data is present in import */
if isnull(@Street1,'') <> ''
and isnull(@City,'') <> ''
and isnull(@State,'') <> ''
	begin
	set @Street2 = isnull(@Street2,'')
	
	set @pkCPClientAddress = null
	
	select @pkCPClientAddress = fkCPClientAddress
	from	CPJoinClientClientAddress
	where	fkCPClient = @pkCPClient
	and		fkCPRefClientAddressType = @fkCPRefClientAddressType
	
	if @pkCPClientAddress is null
		begin
		exec dbo.uspCPClientAddressInsert
			@fkCPRefClientAddressType = @fkCPRefClientAddressType
			, @Street1 = @Street1
			, @Street2 = @Street2
			, @Street3 = ''
			, @City = @City
			, @State = @State
			, @Zip = @Zip
			, @ZipPlus4 = @ZipPlus4
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
			, @pkCPClientAddress = @pkCPClientAddress output

		exec dbo.uspCPJoinClientClientAddressInsert
			@fkCPClient = @pkCPClient
			, @fkCPClientAddress = @pkCPClientAddress
			, @fkCPRefClientAddressType = @fkCPRefClientAddressType
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		end
	else
		begin
		exec dbo.uspCPClientAddressUpdate
			@pkCPClientAddress = @pkCPClientAddress
			, @fkCPRefClientAddressType = @fkCPRefClientAddressType
			, @Street1 = @Street1
			, @Street2 = @Street2
			, @Street3 = null
			, @City = @City
			, @State = @State
			, @Zip = @Zip
			, @ZipPlus4 = @ZipPlus4
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		end
	end
