create view dbo.alvSelfScanKiosk_MatStepOffDeactivation
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
,ConfiguredDelaySeconds = DecimalData1
from ActivityLog
where fkrefActivityType = 37