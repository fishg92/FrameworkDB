






/* 
[uspGetUserList] 3
*/

CREATE PROC [dbo].[uspGetUserList]
(	@fkProfile decimal = NULL
)
As

if @fkProfile is null BEGIN
	SELECT a.pkApplicationUser
	,a.Username
	,a.Firstname
	,a.LastName 
	,IsActive = isnull(a.IsActive, 1) 
	,IsCaseworker = isnull(a.IsCaseworker,0)
	from ApplicationUser a with (NOLOCK)

	order by username
END ELSE BEGIN
SELECT distinct
	a.pkApplicationUser
	,a.Username
	,a.Firstname
	,a.LastName 
	,IsActive = isnull(a.IsActive, 1) 
	,IsCaseworker = isnull(a.IsCaseworker,0)
	from ApplicationUser a 	with (NOLOCK)
	inner join JoinApplicationUserRefRole jar 	with (NOLOCK) 
		on a.pkApplicationUser = jar.fkApplicationUser
	inner join JoinRefRoleProfile jrp 	with (NOLOCK)
		on jrp.fkrefRole = jar.fkrefRole and jrp.fkProfile = @fkProfile

END
