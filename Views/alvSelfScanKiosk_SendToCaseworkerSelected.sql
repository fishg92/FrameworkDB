create view dbo.alvSelfScanKiosk_SendToCaseworkerSelected
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
,FrontSides = DecimalData2
,BackSides = DecimalData3
from ActivityLog
where fkrefActivityType = 36