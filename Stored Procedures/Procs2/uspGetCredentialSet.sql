


CREATE PROC [dbo].[uspGetCredentialSet]
(	@fkApplicationUser decimal 
)
AS

/*
Replace Description in refCredentialType
with appropriate DMS name
*/

declare @Dms varchar(300)

select @Dms = ItemValue
from dbo.Configuration with (nolock)
where ItemKey = 'DMS'

select pkrefCredentialType
		,Description =
		case
			when pkrefCredentialType = -2
				then isnull(@Dms,Description)
			else Description
		end
from refCredentialType with (NOLOCK)

select 
pkJoinApplicationUserRefCredentialType
,fkApplicationUser
,fkrefCredentialType
,UserName
,Password
from dbo.JoinApplicationUserRefCredentialType  with (NOLOCK)
where fkApplicationUser = @fkApplicationUser





