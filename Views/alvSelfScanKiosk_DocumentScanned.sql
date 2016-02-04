create view dbo.alvSelfScanKiosk_DocumentScanned
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
,NameSelected = Data1
,SSN = Data2
,LanguageName = Data3
,ScreenSelected = Data4
,NumberOfPagesScanned = DecimalData1
,IsFront = BitData1
from ActivityLog
where fkrefActivityType = 31