


CREATE  Proc [dbo].[spCPImportCPClientAddressV2] (
	@Street1 varchar(50)
	,@Street2 varchar(50)
	,@City varchar(50)
	,@State varchar(10)
	,@Zip varchar(10)
	,@ZipPlus4 varchar(10)
	,@pkCPRefAddressType decimal(18,0)
	,@EffectiveDate Datetime = null --not used but left for compatability
	,@pkCPClientAddress decimal (18,0) Output
	,@pkCPRefImportLogEventType decimal (18,0) = Null Output
)
as

Declare	
	@HostName varchar(100)
	,@fkCPRefClientAddressTypeCurrent Decimal
	,@Street1Current varchar(100)
	,@Street2Current varchar(100)
	,@Street3Current varchar(100)
	,@CityCurrent varchar(100)
	,@StateCurrent varchar(50)
	,@ZipCurrent char(5) 
	,@ZipPlus4Current char(4)
	,@fkCPRefClientAddressType decimal
	,@Street3 varchar(100)
	,@Street1Formatted varchar(50)
	,@Street2Formatted varchar(50)
	,@CityFormatted varchar(50)
	,@StateFormatted varchar(10)
	,@ZipFormatted varchar(10)
	,@ZipPlus4Formatted varchar(10)
	,@pkCPImportLog decimal

select @HostName = host_name()

select 
	@Street1Formatted = rtrim(ltrim(isnull(@Street1,'')))
	,@Street2Formatted = rtrim(ltrim(isnull(@Street2,'')))
	,@CityFormatted = rtrim(ltrim(isnull(@City,'')))
	,@StateFormatted = rtrim(ltrim(isnull(@State,'')))
	,@ZipFormatted = rtrim(ltrim(isnull(@Zip,'')))
	,@ZipPlus4Formatted = Replicate('0', 4 - Len(isnull(@ZipPlus4,''))) + isnull(@ZipPlus4,'')
	if rtrim(ltrim(@ZipPlus4Formatted)) = '0000' begin
		set @ZipPlus4Formatted = ''
	end


if @Street1Formatted = '' 
	AND @Street2Formatted = ''
	AND @CityFormatted = ''
	AND @StateFormatted = ''
	AND @ZipFormatted = ''
	AND @ZipPlus4Formatted = ''
begin
	select @pkCPClientAddress = 0
end else begin

	set @pkCPClientAddress = 0

	select @pkCPClientAddress = dbo.fnCPImportFindAddress(
										@Street1Formatted
										,@Street2Formatted
										,@CityFormatted
										,@StateFormatted
										,@ZipFormatted
										,@ZipPlus4Formatted
										,@pkCPRefAddressType
										)

	If @pkCPClientAddress <> 0 begin
		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 13
			,@fkCPClientAddress = @pkCPClientAddress

		Select
			@fkCPRefClientAddressTypeCurrent = fkCPRefClientAddressType
			,@Street1Current=Street1
			,@Street2Current=Street2
			,@Street3Current=Street3
			,@CityCurrent=City
			,@StateCurrent=State
			,@ZipCurrent=Zip
			,@ZipPlus4Current=ZipPlus4
		from CPClientAddress
		where pkCPClientAddress = @pkCPClientAddress

		If 	rtrim(ltrim(isnull(@Street1Current,'')))<>@Street1Formatted
			OR rtrim(ltrim(isnull(@Street2Current,'')))<>@Street2Formatted
			OR rtrim(ltrim(isnull(@CityCurrent,'')))<>@CityFormatted
			OR rtrim(ltrim(isnull(@StateCurrent,'')))<>@StateFormatted
			OR rtrim(ltrim(isnull(@ZipCurrent,'')))<>@ZipFormatted
			OR 
				(
				rtrim(ltrim(isnull(@ZipPlus4Current,'')))<>@ZipPlus4Formatted
				AND @ZipPlus4Formatted <> ''
				)
		begin
			exec dbo.uspCPClientAddressUpdate
				@pkCPClientAddress=@pkCPClientAddress
				, @fkCPRefClientAddressType=@fkCPRefClientAddressTypeCurrent
				, @Street1=@Street1
				, @Street2=@Street2
				, @Street3=@Street3Current
				, @City=@City
				, @State=@State
				, @Zip=@Zip
				, @ZipPlus4=@ZipPlus4
				, @LUPUser=@HostName
				, @LUPMac=@HostName
				, @LUPIP=@HostName
				, @LUPMachine=@HostName

			exec dbo.spCPInsertCPImportLog
				@pkCPImportLog = @pkCPImportLog Output
				,@fkCPRefImportLogEventType = 14
				,@fkCPClientAddress = @pkCPClientAddress

		end
	end else begin
		exec dbo.uspCPClientAddressInsert
				@fkCPRefClientAddressType=@pkCPRefAddressType
				, @Street1=@Street1
				, @Street2=@Street2
				, @City=@City
				, @State=@State
				, @Zip=@Zip
				, @ZipPlus4=@ZipPlus4
				, @LUPUser=@HostName
				, @LUPMac=@HostName
				, @LUPIP=@HostName
				, @LUPMachine=@HostName
				, @pkCPClientAddress = @pkCPClientAddress output

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 12
			,@fkCPClientAddress = @pkCPClientAddress

	end

end

