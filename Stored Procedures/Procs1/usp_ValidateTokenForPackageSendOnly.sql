




--[usp_ValidateToken] '9d164a70-24be-4279-909c-18b801780848-a3e949ef-521a-4847-b849-04baa230ae60'


CREATE PROC [dbo].[usp_ValidateTokenForPackageSendOnly]
(	@AuthToken as varchar(75)
	, @pkBenefitPackage as decimal
)
As

declare @Result as tinyint
set @Result = 0
if @AuthToken like '[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]'
	begin

	if exists
		(select * from dbo.PublicAuthenticatedSession 
			inner join BenefitPackage bp on bp.fkApplicationUser = PublicAuthenticatedSession.fkApplicationUser
				and bp.pkBenefitPackage = @pkBenefitPackage
			where AuthenticationToken = @AuthToken
		)
		BEGIN
		set @Result = 1
		END
	end
	
select @Result


