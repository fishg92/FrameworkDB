
-- [usp_GetReportsByUser] 1

CREATE procedure [dbo].[usp_GetReportsByUser]
(	@pkApplicationUser decimal
)
as

 select 
pkReport
,FriendlyName
,fkNCPApplication
From Report with (NOLOCK) 
	inner join NCPApplication on pkNCPApplication = fkNCPApplication
	where pkNCPApplication in 
	(select fkApplication from refPermission rp
	inner join JoinRefRoleRefPermission jrp
	on jrp.fkrefPermission = rp.pkrefPermission
	inner join JoinApplicationUserrefRole j
	on j.fkrefrole = jrp.fkrefRole
	and j.fkApplicationUser = @pkApplicationUser
	and isnull(rp.RequiredForThisApplication,0) = 1)
and Registered = 1







