


/*
exec [GetCoPilotFormsForSync] 1,1
*/
CREATE proc [dbo].[GetCoPilotFormsForSync]
	@pkApplicationUser decimal
	,@pkConnectType decimal
as
select distinct fn.pkFormName
,fn.FriendlyName
,FormDocType = isnull(fn.FormDocType,'')
, et.pkEventType
, (select max(AuditStartDate) from FormImagePageAudit where fkformname = fn.pkFormName) ImageChangeDate
, (select max(AuditStartDate) from FormAnnotationAudit where fkForm = fn.pkFormName) AnnotationChangeDate
, (select max(AuditStartDate)  from formnameaudit where pkFormName = fn.pkFormName) FormPropertyChangeDate
from 
 joineventtypeConnecttype jevtr 
inner join EventType et on jevtr.fkEventType = et.pkEventType
inner join JoinEventTypeFormName j on j.fkEventType = et.PkEventType
inner join Formname fn on j.fkFormName = fn.pkFormName
where jevtr.fkConnectType = @pkConnectType
