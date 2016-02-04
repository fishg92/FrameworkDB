CREATE PROC [dbo].[uspGetUserListForApplication]
(	@fkApplication decimal 
)
As
SELECT distinct
	a.pkApplicationUser
	,a.Username
	,a.Firstname
	,a.LastName 
	,IsActive = isnull(a.IsActive, 1) 
	from ApplicationUser a 	with (NOLOCK)
	WHERE pkApplicationUser in
	(select fkApplicationUser from JoinApplicationUserrefRole j
	inner join refrole rr
	on j.fkrefrole = rr.pkrefrole
	inner join JoinRefRoleRefPermission jrp
	ON jrp.fkrefrole = rr.pkrefrole
	INNER JOIN refPermission rp
	ON rp.pkrefpermission = jrp.fkrefpermission
	where rp.fkApplication = @fkApplication
	and isnull(rp.RequiredForThisApplication,0) = 1)




SET ANSI_NULLS OFF
