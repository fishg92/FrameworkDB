
CREATE proc [dbo].[MatchCompassNumberToCaseNumberSSN]
 @CaseNumber varchar(20)
,@SSN varchar (11)
as

Declare @ErrorMessage as varchar (255)
Declare @TotalMatchingRecords decimal (18,0)
Declare @CompassNumber as varchar (50) 
set @CompassNumber = -1
set @ErrorMessage = 'Success'

If len(@SSN) <> 11
	begin
	set @SSN = Replace (@SSN, '-', '') 
	set @SSN = SubString(@SSN,1, 3) + '-' + Substring(@SSN,4,2) + '-' + SubString(@SSN, 6,4)  
	end
If len(@SSN) > 11
	set @ErrorMessage = 'Invalid SSN - ' + @SSN

set @TotalMatchingRecords = (
	Select count (Distinct [Compass Number])
	from dbo.CompassClientInformation (nolock)
	where SSN = @SSN
	and [Case Number] = @CaseNumber
	and [Compass Number] is not null
	and [Case Number] is not null)

If @TotalMatchingRecords = 1
	begin
		(Select top 1  @ErrorMessage as [ErrorMessage], [Case Number ] as CaseNumber, isnull(CaseWorker, '') as [CaseWorker], [Compass Number] as CompassNumber, [First Name] as FirstName, MI as MiddleName, [Last Name] as LastName, SSN ,  'Import' as Source, 'Conversion' as SubmittedBy
		from dbo.CompassClientInformation (nolock)
		where SSN = @SSN
		and [Case Number] = @CaseNumber
		and [Compass Number] is not null
		and [Case Number] is not null)
	end 
Else
	Begin
		If @TotalMatchingRecords = 0
			set @ErrorMessage = 'SSN: ' + @SSN + ' Case Number: ' +@CaseNumber + '   Error: No matching client records were found.' 
		Else
			set @ErrorMessage = 'SSN: ' + @SSN + ' Case Number: ' +@CaseNumber +  '   Error: (' + cast(@TotalMatchingRecords as varchar(50)) + ')' +' matching client records were found.'  
		Select @ErrorMessage as [ErrorMessage]
		,'-1' as CaseNumber, '' as [CaseWorker], -1 as CompassNumber, '' as FirstName, '' as MiddleName, '' as LastName, '' as SSN,  'Import' as Source, 'Conversion' as SubmittedBy
	End
