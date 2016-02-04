create view dbo.alvMyWork_FollowupCreated
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
,FollowupDate = DateData1
from ActivityLog
where fkrefActivityType = 12