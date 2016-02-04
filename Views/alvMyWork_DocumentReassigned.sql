create view dbo.alvMyWork_DocumentReassigned
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
,FkApplicationUserOriginal = DecimalData1
,FkApplicationUserNew = DecimalData2
,NumberOfReassignments = DecimalData3
from ActivityLog
where fkrefActivityType = 11