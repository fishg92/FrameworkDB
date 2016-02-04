create view dbo.alvDocuments_DocumentTypeChanged
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
,FkDocumentTypeOriginal = Data2
,FkDocumentTypeNew = Data3
from ActivityLog
where fkrefActivityType = 10