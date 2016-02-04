create view dbo.alvSelfScanKiosk_InvalidSSNEntered
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
,SSN = Data2
,LanguageName = Data3
,ScreenSelected = Data4
from ActivityLog
where fkrefActivityType = 28