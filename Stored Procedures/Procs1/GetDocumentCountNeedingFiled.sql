
CREATE procedure [dbo].[GetDocumentCountNeedingFiled]
(
	@pkBenefitApplicationUser decimal
) 

as

set nocount on

declare @DocCountNeedingFiled int

select @DocCountNeedingFiled = count(*)
from (select ba.*
	  from dbo.JoinMainApplicantToDependantApplicant jm
	  join dbo.BenefitApplicationDocument ba on ba.fkBenefitApplicationUser = jm.fkDependantBenefitApplicationUser
	  where jm.fkBenefitApplicationUser = @pkBenefitApplicationUser
	  and isnull(ba.fkBenefitDocumentStatus, 1) = 2

	  union 

	  select *
	  from dbo.BenefitApplicationDocument 
	  where fkBenefitApplicationUser = @pkBenefitApplicationUser
	  and isnull(fkBenefitDocumentStatus, 1) = 2) DocCounts

return @DocCountNeedingFiled