create view dbo.alvForms_FormSubmittedToDMS
as
select
pkActivityLog
,ActivityID
,fkApplicationUser
,fkDepartment
,fkAgencyLOB
,ParentActivityID
,ActivityDate
,MachineName
,FkFormName = Data1
,SecondsToFillOut = DecimalData1
from ActivityLog
where fkrefActivityType = 4