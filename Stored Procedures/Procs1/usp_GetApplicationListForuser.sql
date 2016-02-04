

--[usp_GetApplicationListForUser] 1

CREATE PROC [dbo].[usp_GetApplicationListForuser]
(@pkApplicationUser as decimal
)
As
/*
SELECT 
pkNCPApplication
,AppID
,ApplicationName
,CurrentVersion
,AssemblyName
,Registered
,DefaultAppOrder
*/
select * 
,AutoLaunch =
Case when exists (select * from 
	UserSettings us where Grouping = 'AutoLaunchApplication' and ItemKey =  convert(varchar,pkNCPApplication)
		and us.fkApplicationUser = @pkApplicationUser
		) then 1 else 0
end
 From NCPApplication
where pkNCPApplication in 
	(select fkApplication from refPermission rp
	inner join JoinRefRoleRefPermission jrp
	on jrp.fkrefPermission = rp.pkrefPermission
	inner join JoinApplicationUserrefRole j
	on j.fkrefrole = jrp.fkrefRole
	where j.fkApplicationUser = @pkApplicationUser
	and isnull(rp.RequiredForThisApplication,0) = 1)
and Registered = 1



