create view dbo.alvSelfScanKiosk_TouchScreenClick
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
,XPosition = DecimalData1
,YPosition = DecimalData2
from ActivityLog
where fkrefActivityType = 43