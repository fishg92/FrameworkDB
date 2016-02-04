
CREATE PROCEDURE [dbo].[GetAllFormAnnotationSharedObjects]
(
	@pkApplicationUser decimal 
)
AS

select so.pkFormAnnotationSharedObject, so.ObjectName, so.BinaryData, isnull(uso.Value, so.StringData) as ValueText,

case when pkFormUserSharedObject IS NULL       
then (select max(AuditStartDate) from FormAnnotationSharedObjectAudit auditso
	where so.pkFormAnnotationSharedObject = auditso.pkFormAnnotationSharedObject)
else (select max(AuditStartDate) from FormUserSharedObjectAudit audituso 
	where uso.pkFormUserSharedObject = audituso.pkFormUserSharedObject)
end LastUpdate

from FormAnnotationSharedObject so
left join FormUserSharedObject uso on uso.fkFormAnnotationSharedObject = so.pkFormAnnotationSharedObject and uso.fkFrameworkUserID = @pkApplicationUser
where so.Active = 1
order by so.pkFormAnnotationSharedObject
