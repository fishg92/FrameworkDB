create view dbo.alvForms_FormDesignSaved
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
,FkFormName = Data1
,FieldCount = DecimalData1
,NamedFieldCount = DecimalData2
,ConcatenatedFieldCount = DecimalData3
,SingleUseFieldCount = DecimalData4
,DropListCount = DecimalData5
from ActivityLog
where fkrefActivityType = 6