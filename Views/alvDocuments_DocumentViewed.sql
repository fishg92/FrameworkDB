create view dbo.alvDocuments_DocumentViewed
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
,FkDocumentType = Data2
,DownloadSeconds = DecimalData1
from ActivityLog
where fkrefActivityType = 8