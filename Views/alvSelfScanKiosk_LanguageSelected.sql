create view dbo.alvSelfScanKiosk_LanguageSelected
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
,LanguageName = Data3
,ScreenSelected = Data4
from ActivityLog
where fkrefActivityType = 26