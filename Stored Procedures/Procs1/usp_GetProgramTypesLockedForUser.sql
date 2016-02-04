



CREATE      procedure [dbo].[usp_GetProgramTypesLockedForUser] 
(
@fkApplicationUser decimal (18,0)
)
				
as
set nocount on

select pkProgramType 
from dbo.ProgramType (nolock)
where pkProgramType Not in (
		Select fkProgramType 
		from dbo.JoinApplicationUserProgramType (nolock)
		where   fkApplicationUser = @fkApplicationUser
							)




