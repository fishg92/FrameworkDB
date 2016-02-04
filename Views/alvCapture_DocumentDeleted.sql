create view dbo.alvCapture_DocumentDeleted
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
,FkDocumentType = Data1
from ActivityLog
where fkrefActivityType = 2