CREATE proc [dbo].[OBUserSessionSelect]
	@OBUserName varchar(50)
as

select	OBUserName
		,SessionID
		,ServiceURL
		,ServiceDataSource
from OBUserSession
where OBUserName = @OBUserName