/*
exec SearchAutofill @LastName = 'smi'
*/

CREATE                 procedure [dbo].[SearchAutofillByCaseNumber] (@CaseNumber varchar(50)
				) 
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

where CaseNumber = @CaseNumber
