create view dbo.alvForms_FormClosedWithoutEntry
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
from ActivityLog
where fkrefActivityType = 5