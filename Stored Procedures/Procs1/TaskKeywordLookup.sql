CREATE proc [dbo].[TaskKeywordLookup]
	@pkCPClient decimal = null
	,@pkCPClientCase decimal = null
	,@ClientFirstName varchar(100) = null output
	,@ClientMiddleName varchar(100) = null output
	,@ClientLastName varchar(100) = null output
	,@ClientSSN varchar(10) = null output
	,@StateCaseNumber varchar(20) = null output
	,@LocalCaseNumber varchar(20) = null output
	,@CompassNumber varchar(50) = null output
as

set @ClientFirstName = ''
set @ClientMiddleName = ''
set @ClientLastName = ''
set @ClientSSN = ''
set @StateCaseNumber = ''
set @LocalCaseNumber = ''
set @CompassNumber = ''

if @pkCPClient is not null
	begin
	select	@ClientFirstName = isnull(FirstName,'')
			,@ClientMiddleName = isnull(MiddleName,'')
			,@ClientLastName = isnull(LastName,'')
			,@ClientSSN = ltrim(rtrim(isnull(SSN,'')))
			,@CompassNumber = isnull(NorthwoodsNumber,'')
	from	CPClient
	where	pkCPClient = @pkCPClient
	end
	
if @pkCPClientCase is not null
	begin
	select	@StateCaseNumber = isnull(StateCaseNumber,'')
			,@LocalCaseNumber = isnull(LocalCaseNumber,'')
	from	CPClientCase
	where	pkCPClientCase = @pkCPClientCase
	end
	
