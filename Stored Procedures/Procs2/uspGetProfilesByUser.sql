

--[uspGetProfilesByUser] -1

CREATE PROC [dbo].[uspGetProfilesByUser]
(
	@pkUser decimal	
)
AS

	
	if @pkUser <> -1 BEGIN
	select 
	pkProfile
	,Description
	,LongDescription
	 from Profile with (NOLOCK) 
	where pkProfile in 
	(select fkProfile from JoinrefRoleProfile with (NOLOCK)
	 where fkrefRole in 
	  (select fkrefRole from JoinApplicationUserrefRole with (NOLOCK)
		where fkApplicationUser = @pkUser)
	 )

END ELSE BEGIN
	select 
	pkProfile
	,Description
	,LongDescription
	 from Profile with (NOLOCK) 
END


