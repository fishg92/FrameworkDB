
/* 
uspGetProfileInfo -1
*/

CREATE PROC [dbo].[uspGetProfileInfo]
	@fkProfile decimal

As

select	pkProfile
		,Description
		,LongDescription
		,fkrefTaskOrigin
		,RecipientMappingKeywordType
		,SendDocumentToWorkflow
from profile with (NOLOCK)
where pkProfile = @fkProfile

union

select	-1
		,'New profile'
		,''
		,-1
		,''
		,0
where	@fkProfile = -1

select	pkrefRole
		,Description
from refRole with (NOLOCK)

select	pkJoinrefRoleProfile
		,fkrefRole
		,fkProfile
from JoinrefRoleProfile with (NOLOCK) where fkProfile in (@fkProfile,-1)

	select 
	s.pkAutofillSchemaDataView
	, s.fkAutofillSchema
	,s.FriendlyName from AutoFillSchemaDataView s with (NOLOCK)
	inner join AutofillSchema a on fkAutofillSchema = a.pkAutofillSchema 


	select pkJoinProfileAutoFillSchemaDataView
	,fkProfile
	,fkAutoFillSchemaDataView 
	from dbo.JoinProfileAutoFillSchemaDataView j with (NOLOCK)
	inner join AutofillSchemaDataView v on j.fkAutofillSchemaDataView = v.pkAutofillSchemaDataView
	inner join AutofillSchema a on v.fkAutofillSchema = a.pkAutofillSchema 
	where fkProfile in (@fkProfile, -1)
