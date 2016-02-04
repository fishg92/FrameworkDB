-- Stored Procedure

-- exec [uspGetUserListForApplicationAndProgramType] -1,-1
CREATE PROC [dbo].[uspGetUserListForApplicationAndProgramType]
(	@fkApplication decimal 
	,@fkProgramType decimal = null
)
As
if isnull(@fkProgramType,-1) = -1 BEGIN
	SELECT distinct
		a.pkApplicationUser
		,a.Username
		,a.Firstname
		,a.LastName 
		,a.fkDepartment
		,d.fkAgencyLOB
		,CountyCode = isnull(a.CountyCode, '') 
		,IsActive = isnull(IsActive, 1)
		from ApplicationUser a 	with (NOLOCK)
		inner join Department d
		on a.fkDepartment = d.pkDepartment
		inner join AgencyLOB lob
		on lob.pkAgencyLOB = d.fkAgencyLOB

		WHERE pkApplicationUser in
		(select fkApplicationUser from JoinApplicationUserrefRole j
		inner join refrole rr
		on j.fkrefrole = rr.pkrefrole
		inner join JoinRefRoleRefPermission jrp
		ON jrp.fkrefrole = rr.pkrefrole
		INNER JOIN refPermission rp
		ON rp.pkrefpermission = jrp.fkrefpermission
		where rp.fkApplication = @fkApplication
		and isnull(rp.RequiredForThisApplication,0) = 1) or @fkApplication = -1
END ELSE BEGIN
	SELECT distinct
		a.pkApplicationUser
		,a.Username
		,a.Firstname
		,a.LastName
		,a.fkDepartment
		,d.fkAgencyLOB 
		,CountyCode = isnull(a.CountyCode, '') 
		,IsActive = isnull(IsActive, 1)
		from ApplicationUser a 	with (NOLOCK)

		inner join Department d
		on a.fkDepartment = d.pkDepartment
		inner join AgencyLOB lob
		on lob.pkAgencyLOB = d.fkAgencyLOB
		WHERE pkApplicationUser in
			(select j.fkApplicationUser from JoinApplicationUserrefRole j
			inner join refrole rr
				on j.fkrefrole = rr.pkrefrole
			inner join JoinRefRoleRefPermission jrp
				ON jrp.fkrefrole = rr.pkrefrole
			INNER JOIN refPermission rp
				ON rp.pkrefpermission = jrp.fkrefpermission
			inner join JoinApplicationUserProgramType jar with (NOLOCK) 
				on a.pkApplicationUser = jar.fkApplicationUser
			and jar.fkProgramType = @fkProgramType
			where rp.fkApplication = @fkApplication
			and isnull(rp.RequiredForThisApplication,0) = 1
			) or 
			(@fkApplication = -1 and pkApplicationUser in
				(select jar.fkApplicationUser from
				JoinApplicationUserProgramType jar with (NOLOCK) 
				where jar.fkProgramType = @fkProgramType
				)
			)
END
SET ANSI_NULLS OFF


