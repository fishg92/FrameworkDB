/*
exec SearchAutofill @LastName = 'smi'
*/

CREATE                 procedure [dbo].[SearchAutofillByLastName] (@LastName varchar(40)) 
as
set nocount on
set transaction isolation level read uncommitted

set @LastName = rtrim(@LastName)

if len(@LastName) =1 BEGIN
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
where LastName1char = @LastName

END ELSE if len(@LastName) = 2 BEGIN
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
where LastName2char = @LastName

END ELSE  if len(@LastName) = 3 BEGIN

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
where LastName3char = @LastName

END ELSE  if len(@LastName) = 4 BEGIN

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
where LastName4char = @LastName

END ELSE  if len(@LastName) = 5 BEGIN

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
where LastName5char = @LastName

END else begin


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
where LastName + '%' like  @LastName

end
