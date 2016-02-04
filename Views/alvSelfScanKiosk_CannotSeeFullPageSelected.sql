create view dbo.alvSelfScanKiosk_CannotSeeFullPageSelected
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
from ActivityLog
where fkrefActivityType = 32