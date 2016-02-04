

CREATE   FUNCTION [dbo].[fnProcessCPUpdateFindClient](
	@FirstName varchar(50)
	,@LastName Varchar(50)
	,@MiddleName varchar(50)
	,@SSN varchar(10)
	,@BirthDate datetime
	,@Sex char(1)
	,@ExternalSystemName varchar(50)
	,@ExternalSystemID varchar(50)
)

RETURNS decimal
AS
BEGIN
	DECLARE @pkCPClient Decimal
			,@SSNIsException bit
			
	set @pkCPClient = null
	
	set @SSN = dbo.StripPhone(@SSN)
	set @BirthDate = isnull(@BirthDate,'1/1/1900')
	set @SSNIsException = dbo.fnSSNIsException(@SSN)
	
	/**********************************
	Match on external system ID
	*******************************/
	set	@pkCPClient = (select top 1 fkCPClient
	from	CPClientExternalID
	where	ExternalSystemName = @ExternalSystemName
	and		ExternalSystemID = @ExternalSystemID)
	
	/****************************
	Match on SSN
	**************************/
	if @pkCPClient is null
	and @SSNIsException = 0
		begin
		Set @pkCPClient = (select top 1 pkCPClient
		From	CPClient
		Where	SSN = @SSN
		and not exists (select	*
						from	CPClientExternalID
						where	fkCPClient = CPClient.pkCPClient
						and		ExternalSystemName = @ExternalSystemName)
		order by pkCPClient)
		end
		
	/*************************
	Match on name and DOB
	************************/
	if @pkCPClient is null
	and @BirthDate <> '1/1/1900'
	and @SSNIsException = 1
		begin
		set	@pkCPClient = (select top 1 pkCPClient
		from	CPClient
		where	FirstName = @FirstName
		and		LastName = @LastName
		and		BirthDate = @BirthDate
		and not exists (select	*
						from	CPClientExternalID
						where	fkCPClient = CPClient.pkCPClient
						and		ExternalSystemName = @ExternalSystemName)
		order by pkCPClient)
		end
		
	/*************************
	Match on last name, first initial, sex, and DOB
	************************/
	if @pkCPClient is null
	and @BirthDate <> '1/1/1900'
	and	@SSNIsException = 1
		begin
		set	@pkCPClient = (select top 1 pkCPClient
		from	CPClient
		where	FirstName like substring(@FirstName,1,1) + '%'
		and		LastName = @LastName
		and		BirthDate = @BirthDate
		and		Sex = @Sex
		and not exists (select	*
						from	CPClientExternalID
						where	fkCPClient = CPClient.pkCPClient
						and		ExternalSystemName = @ExternalSystemName)
		order by pkCPClient)
		end
		
	/*************************
	Match on last name, first initial, and DOB
	************************/
	if @pkCPClient is null
	and @BirthDate <> '1/1/1900'
	and	@SSNIsException = 1
		begin
		set	@pkCPClient =(select top 1 pkCPClient
		from	CPClient
		where	FirstName like substring(@FirstName,1,1) + '%'
		and		LastName = @LastName
		and		BirthDate = @BirthDate
		and not exists (select	*
						from	CPClientExternalID
						where	fkCPClient = CPClient.pkCPClient
						and		ExternalSystemName = @ExternalSystemName)
		order by pkCPClient)
		
		end
		
	
	RETURN isnull(@pkCPClient,0)
END









