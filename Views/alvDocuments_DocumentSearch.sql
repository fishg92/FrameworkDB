create view dbo.alvDocuments_DocumentSearch
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
,Parameter1Name = Data1
,Parameter1Value = Data2
,Parameter2Name = Data3
,Parameter2Value = Data4
,Parameter3Name = Data5
,Parameter3Value = Data6
,Parameter4Name = Data7
,Parameter4Value = Data8
,CountReturned = DecimalData1
,SearchTimeSeconds = DecimalData2
from ActivityLog
where fkrefActivityType = 7