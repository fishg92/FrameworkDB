

CREATE   FUNCTION [dbo].[fnCPImportFindClient](
	@FirstName varchar(50)
	,@LastName Varchar(50)
	,@MiddleName varchar(50)
	,@SSN varchar(10)
	,@BirthDate datetime
	,@StateIssuedNumber varchar(50)
	,@Sex char(1)
)

RETURNS decimal
AS
BEGIN
	DECLARE @pkCPClient Decimal
	select @pkCPClient = 0

	Select 	@pkCPClient = pkCPClient
	From	CPClient
	Where	StateIssuedNumber = @StateIssuedNumber

	if @pkCPClient = 0 begin
		If @SSN <> '000000000' begin
			Select @pkCPClient = pkCPClient
			From	CPClient
			Where	LTRim(RTrim(IsNull(SSN,'000000000'))) = @SSN

			if @pkCPClient = 0 begin
				If @BirthDate <> '1/1/1900' 
					and	@FirstName <> ''
					and	@LastName <> '' begin
						Select @pkCPClient = pkCPClient
						From	CPClient
						Where	isnull(BirthDate,'1/1/1900') = @BirthDate
						and	LTRim(RTrim(IsNull(FirstName,''))) = @FirstName
						and	LTRim(RTrim(IsNull(LastName,''))) = @LastName
						and LTRim(RTrim(IsNull(StateIssuedNumber,''))) = ''
						and (LTRim(RTrim(IsNull(SSN,'000000000')))  = '000000000'
							Or LTRim(RTrim(IsNull(SSN,'')))  = '')
				end
			end
		end else begin
			If @BirthDate <> '1/1/1900' 
				and	@FirstName <> ''
				and	@LastName <> '' begin
					Select @pkCPClient = pkCPClient
					From CPClient
					Where isnull(BirthDate,'1/1/1900') = @BirthDate
					and	LTRim(RTrim(IsNull(FirstName,''))) = @FirstName
					and	LTRim(RTrim(IsNull(LastName,''))) = @LastName
					and LTRim(RTrim(IsNull(StateIssuedNumber,''))) = ''
			end
		end
	end

	RETURN @pkCPClient
END









