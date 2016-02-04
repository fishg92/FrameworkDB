CREATE PROCEDURE [dbo].[spCpGetNarrativeHistory]
	@pkCPCaseActivity decimal(18,0)
 --spCPGetNarrativeHistory 1602

as

set nocount on

select distinct * from (
select c1.pkCPCaseActivity
	, fkCPCaseActivityType = case when c1.AuditDeleted = 1 then 8 else 1 end
	, c1.[Description]
	, CreateDate = case when c2.pk is null AND c1.EffectiveCreateDate is not null then c1.EffectiveCreateDate else c1.AuditStartDate end
	, CreateUser = Username
	, c1.fkCPClientCase
	, c1.fkCPClient
	, CaseActivityTypeName = 'Narrative'
	, Username
from CPCaseActivityAudit c1
left join ApplicationUser AppUser on c1.AuditUser = AppUser.pkapplicationuser
left join CPCaseActivityAudit c2 
	on c1.pkCPCaseActivity = c2.pkCPCaseActivity
	and c1.pk > c2.pk
where c1.pkCPCaseActivity = @pkCPCaseActivity
) a
order by a.CreateDate