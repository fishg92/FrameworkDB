
CREATE    PROC [dbo].[usp_AuthenticateUser] @Username varchar(50), @Password varchar(200)
As
select 
	dbo.ApplicationUser.* 
	from  ApplicationUser   with (NOLOCK) 
	where upper(Username) = upper(@UserName)
	and   upper([Password]) = upper(@Password)
	and isnull(LDAPUser,0) = 0
	and isnull([IsActive],1)  = 1

SELECT b.*, c.* FROM ApplicationUser AS a
INNER JOIN dbo.ApplicationUserDefaultRoleAssignment AS b
ON a.pkApplicationUser = b.fkApplicationUser
INNER JOIN dbo.DefaultRole AS c
ON b.fkDefaultRole = c.pkDefaultRole


SELECT TOP 1 AgencyName FROM ApplicationUser AS a
INNER JOIN dbo.JoinApplicationUserAgencyLOB As b
ON b.fkApplicationUser = a.pkApplicationUser
INNER JOIN dbo.AgencyLOB AS c
ON b.fkAgencyLOB = c.pkAgencyLOB
INNER JOIN dbo.AgencyConfig As d
ON d.pkAgencyConfig = c.fkAgency
ORDER BY 1


select fkProgramType from JoinApplicationUserProgramType
	where fkApplicationUser = (select top 1 dbo.ApplicationUser.pkApplicationUser 
		from  ApplicationUser   with (NOLOCK) 
		where upper(Username) = upper(@UserName)
		and   upper([Password]) = upper(@Password)
		and isnull([IsActive],1)  = 1)


select * from JoinApplicationUserrefCredentialType (NOLOCK)
	where fkApplicationUser = 
		(select ApplicationUser.pkApplicationUser
			from  ApplicationUser   with (NOLOCK) 
			where upper(Username) = upper(@UserName)
			and   upper([Password]) = upper(@Password)
			and isnull([IsActive],1)  = 1)
