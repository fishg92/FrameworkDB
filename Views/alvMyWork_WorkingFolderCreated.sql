create view dbo.alvMyWork_WorkingFolderCreated
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
from ActivityLog
where fkrefActivityType = 14