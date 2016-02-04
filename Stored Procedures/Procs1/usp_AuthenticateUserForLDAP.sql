
/* Note.... this proc is being used for performing lookup of a user after LDAP authentication has occurred
Although it serves a similar purpose to the usp_Authenticate user call in the login process, it is not truly
being used for authentication */

CREATE PROC [dbo].[usp_AuthenticateUserForLDAP] 
@LoginName varchar(50)
,@LDAPUniqueID varchar(100)

As
declare @pkApplicationUser decimal

/* LDAPUniqueID is the authorative LDAP identity however need to handle possiblity of system misconfiguration of LDAP property name by defaulting back to username */
IF @LDAPUniqueID <> '' BEGIN
	if exists (select * from ApplicationUser (NOLOCK) where isnull(LDAPUniqueID,'') = @LDAPUniqueID ) BEGIN
		select @pkApplicationUser = pkApplicationUser  from ApplicationUser (NOLOCK) where isnull(LDAPUniqueID,'') = @LDAPUniqueID 
		select * from ApplicationUser (NOLOCK) where isnull(LDAPUniqueID,'') = @LDAPUniqueID  
	END ELSE BEGIN
		select @pkApplicationUser = pkApplicationUser  from ApplicationUser (NOLOCK) where upper(isnull(Username,'')) = upper(@LoginName)  
		select * from ApplicationUser (NOLOCK) where upper(isnull(Username,'')) = upper(@LoginName) 
	END
END ELSE BEGIN
	select @pkApplicationUser = pkApplicationUser, @LDAPUniqueID = LDAPUniqueID from ApplicationUser (NOLOCK) where upper(isnull(Username,'')) = upper(@LoginName) 
	select * from ApplicationUser (NOLOCK) where upper(isnull(Username,'')) = upper(@LoginName) 
END

update ApplicationUser 
set LDAPUniqueID = @LDAPUniqueID 
--, LDAPUser = 1
where pkApplicationUser = isnull(@pkApplicationUser,-1)
and (isnull(LDAPUser,0) <> 1
or isnull(LDAPUniqueID,'') <> @LDAPUniqueID)

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
		where upper(Username) = upper(@LoginName))

select * from JoinApplicationUserrefCredentialType (NOLOCK)
	where fkApplicationUser = @pkApplicationUser
