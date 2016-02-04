
CREATE proc [dbo].[usp_GetUsersForDepartment]
	@pkDepartment decimal
	,@ExistsOnly bit = 0
as

	if (@ExistsOnly = 0) 
	begin
		select pkApplicationUser
		, UserName
		, FirstName
		, LastName
		, fkDepartment
		, WorkerNumber
		, CountyCode
		, IsCaseworker
		, IsActive = isnull(isactive,1)
		from ApplicationUser 
		where fkDepartment = @pkDepartment
	end
	Else
	begin
		if exists ( select 1 from ApplicationUser 
			where fkDepartment = @pkDepartment ) 
			select 1 as 'UserExists'
		else
			select 0 as 'UserExists'

	end



