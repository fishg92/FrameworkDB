



CREATE      procedure [dbo].[usp_GetSecurityInfoForCPClient] 
(
@fkCPClient decimal (18,0)
)
				
as
set nocount on

select 
  fkApplicationUser
, fkProgramType
, pkLockedEntity 
From LockedEntity (nolock)
inner join dbo.JoinApplicationUserSecureGroup (nolock) on pkLockedEntity = fkLockedEntity
where fkCPClient = @fkCPClient


