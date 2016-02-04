
CREATE procedure [dbo].[GetScanDocumentsStatusForApplication]
(
	@pkBenefitApplicationUser decimal,
	@pkBenefitApplication decimal
) 

as

set nocount on

declare @ActualDocCount int,
		@DocCountNeeded int,
		@DependantCount int,
		@DocTypesRequiredForApp int,
		@DocsStillNeeded int

select @DependantCount = count(*)
from dbo.JoinMainApplicantToDependantApplicant 
where fkBenefitApplicationUser = @pkBenefitApplicationUser 

select @ActualDocCount = count(*)
from (select distinct ba.*
	  from dbo.JoinMainApplicantToDependantApplicant jm
	  join dbo.BenefitApplicationDocument ba on ba.fkBenefitApplicationUser = jm.fkDependantBenefitApplicationUser
	  join dbo.JoinBenefitApplicationBenefitDocumentType jb on jb.fkBenefitDocumentType	= ba.fkBenefitDocumentType
	  where jm.fkBenefitApplicationUser = @pkBenefitApplicationUser
	  --and jb.ScanIsRequired = 1

	  union 

	  select distinct ba.*
	  from dbo.BenefitApplicationDocument ba
	  join dbo.JoinBenefitApplicationBenefitDocumentType jb on jb.fkBenefitDocumentType	= ba.fkBenefitDocumentType
	  where fkBenefitApplicationUser = @pkBenefitApplicationUser) DocCounts
	  --and jb.ScanIsRequired = 1

select @DocTypesRequiredForApp = count(*) 
from dbo.JoinBenefitApplicationBenefitDocumentType
where fkBenefitApplication = @pkBenefitApplication
--and ScanIsRequired = 1

set @DocCountNeeded = @DocTypesRequiredForApp * (@DependantCount + 1)
set @DocsStillNeeded = @DocCountNeeded - @ActualDocCount

if @DocsStillNeeded = 0
	begin
		return 0
	end
else
	begin
		if @ActualDocCount > 0
			begin
				return 1
			end
		else
			begin
				return -1
			end
	end