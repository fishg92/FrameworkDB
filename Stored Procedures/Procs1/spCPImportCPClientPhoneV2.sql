


CREATE Proc [dbo].[spCPImportCPClientPhoneV2] (
	@Number varchar(10)
	,@Extension varchar(10)
	,@fkCPRefPhoneType decimal(18,0)
	,@EffectiveDate datetime = null --not used but left for compatability
	,@pkCPClientPhone decimal(18,0) Output
)
as

declare
	@HostName varchar(100)
	,@NumberCurrent varchar(10)
	,@ExtensionCurrent varchar(10)
	,@fkCPRefPhoneTypeCurrent decimal(18,0)
	,@NumberFormatted varchar(10)
	,@ExtensionFormatted varchar(10)
	,@fkCPRefPhoneTypeFormatted decimal(18,0)
	,@pkCPImportLog decimal

select @HostName = host_name()

select 
	@NumberFormatted = rtrim(ltrim(isnull(@Number,'')))
	,@ExtensionFormatted = rtrim(ltrim(isnull(@Extension,'')))
	,@fkCPRefPhoneTypeFormatted = isnull(@fkCPRefPhoneType,0)

if @NumberFormatted = '' 
	AND @ExtensionFormatted = ''
begin
	select @pkCPClientPhone = 0
end else begin
	set @pkCPClientPhone = 0

	Select	
		@pkCPClientPhone = pkCPClientPhone
		,@NumberCurrent = Number
		,@ExtensionCurrent = Extension
		,@fkCPRefPhoneTypeCurrent = fkCPRefPhoneType
	From	CPClientPhone with (nolock)
	Where	Number = @NumberFormatted 
	and	Extension = @ExtensionFormatted
	and fkCPRefPhoneType = @fkCPRefPhoneTypeFormatted


	if @pkCPClientPhone <> 0 begin
		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 23
			,@fkCPClientPhone = @pkCPClientPhone

	end else begin
		exec dbo.uspCPClientPhoneInsert
			  @fkCPRefPhoneType=@fkCPRefPhoneType
			, @Number=@Number
			, @Extension=@Extension
			, @LUPUser=@HostName
			, @LUPMac=@HostName
			, @LUPIP=@HostName
			, @LUPMachine=@HostName
			, @pkCPClientPhone=@pkCPClientPhone output

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 22
			,@fkCPClientPhone = @pkCPClientPhone

	end
end

