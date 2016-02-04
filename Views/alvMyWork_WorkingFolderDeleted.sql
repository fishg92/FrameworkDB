create view dbo.alvMyWork_WorkingFolderDeleted
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
where fkrefActivityType = 15