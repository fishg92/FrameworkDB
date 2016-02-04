
/*
exec SearchAutofill @LastName = 'smi'
*/

CREATE                  procedure [dbo].[SearchAutofillBySSN] (@SSN varchar(11)) 
as
set nocount on
set transaction isolation level read uncommitted

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

where SSN = @SSN
