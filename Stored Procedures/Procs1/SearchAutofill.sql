
/*
exec SearchAutofill @LastName = 'Sma'
*/

CREATE                  procedure [dbo].[SearchAutofill] (
@pkAutoFill decimal(18,0) = null
,@SSN varchar(11)=  null
,@CaseNumber varchar(50) = null
,@Firstname varchar(40) = null
,@Lastname varchar(100) = null
,@CaseManager varchar(15) = null
)

				
as
set nocount on
set transaction isolation level read uncommitted

--if user specified a pk, get the record and get out
if not(@pkAutoFill is null) BEGIN
select
pkAutoFill
,SSN
,CaseNumber
,FirstName
,LastName
,Address1
,Address2
,City
,State
,Zip
from AutoFill
where pkAutoFill = @pkAutoFill
--if user gave uas lastname info, use more efficient proc
end else if @pkAutoFill is null and @SSN is null and @CaseNumber is null
and @Firstname is null and @CaseManager is null and not (@LastName is null) BEGIN

exec SearchAutoFillByLastName @Lastname = @LastName

END else BEGIN

select
pkAutoFill
,SSN
,CaseNumber
,FirstName
,LastName
,Address1
,Address2
,City
,State
,Zip
from AutoFill

where isnull(@SSN,'') in (SSN,'')
and isnull(@CaseNumber,'') in (CaseNumber,'')
and isnull(@FirstName,'') in (Firstname,'')
and isnull(@Casemanager,'') in (CaseManager,'')

END
