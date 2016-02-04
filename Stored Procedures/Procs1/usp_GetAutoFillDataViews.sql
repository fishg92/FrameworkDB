
-- [usp_GetAutoFillDataViews] -1
CREATE PROC [dbo].[usp_GetAutoFillDataViews]
(
	@pkUser int
)	
AS
	if @pkUser = -1 BEGIN
	SELECT pkAutofillSchemaDataView
		, fkAutofillSchema
		, AutoFillSchemaDataView.FriendlyName
		, IgnoreProgramTypeSecurity
		, IgnoreSecuredClientSecurity
		FROM AutoFillSchemaDataView WITH (NOLOCK)
		inner join AutofillSchema s on fkAutofillSchema = pkAutofillSchema
		END ELSE
		BEGIN
		SELECT pkAutofillSchemaDataView
		, fkAutofillSchema
		, AutofillSchemaDataView.FriendlyName
		, IgnoreProgramTypeSecurity
		, IgnoreSecuredClientSecurity
		FROM AutofillSchemaDataView WITH (NOLOCK)
	inner join AutofillSchema s on fkAutofillSchema = pkAutofillSchema
		where pkAutofillSchemaDataView in 
	(select fkAutoFillSchemaDataView from JoinProfileAutoFillSchemaDataView with (NOLOCK)
		   where fkProfile in 
			(Select fkProfile from JoinrefRoleProfile with (NOLOCK) 
			  where fkrefRole in 
			  (Select fkrefRole from JoinApplicationUserrefRole with (NOLOCK)
			   where fkApplicationUser = @pkUser)
			  )
		  )
		END
