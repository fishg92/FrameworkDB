
/* 
[uspGetUserListForProgramType] 1
*/

CREATE PROC [dbo].[uspGetUserListForProgramType]
(	@fkProgramType decimal 
)
As
SELECT distinct
	a.pkApplicationUser
	,a.Username
	,a.Firstname
	,a.LastName 
	,IsActive = isnull(a.IsActive, 1) 
	from ApplicationUser a 	with (NOLOCK)

	inner join JoinApplicationUserProgramType jar 	with (NOLOCK) 
		on a.pkApplicationUser = jar.fkApplicationUser
	where jar.fkProgramType = @fkProgramType

SET ANSI_NULLS OFF
