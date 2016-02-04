

-- [dbo].[uspGetUsernameExistsWithDifferentKey] 2,'jneno'

CREATE PROC [dbo].[uspGetUsernameExistsWithDifferentKey]
(
	@ProposedpkApplicationUser decimal
	,@Username varchar(50)
)
AS

select case when exists 
(select * from ApplicationUser with (NOLOCK)
where pkApplicationUser <> @ProposedpkApplicationUser
and Username = @Username)
then 1 else 0 end


