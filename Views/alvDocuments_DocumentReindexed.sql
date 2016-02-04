create view dbo.alvDocuments_DocumentReindexed
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
,FkDocument = Data1
from ActivityLog
where fkrefActivityType = 9