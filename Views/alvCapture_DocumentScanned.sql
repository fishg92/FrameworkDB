create view dbo.alvCapture_DocumentScanned
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
,PageCount = DecimalData1
,IsColor = BitData1
,IsDuplex = BitData2
from ActivityLog
where fkrefActivityType = 1