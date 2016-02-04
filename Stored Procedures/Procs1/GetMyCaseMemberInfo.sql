

CREATE PROCEDURE [dbo].[GetMyCaseMemberInfo](
	@pkApplicationUser as decimal(18,0)
)
	
AS
BEGIN
	set nocount on

	select ccase.StateCaseNumber
		   ,ccase.pkCPClientCase
		   ,ccase.LocalCaseNumber
		   ,client.FirstName
		   ,client.LastName
		   ,client.pkCPClient
	from ApplicationUserFavoriteCase fav
		inner join cpclientcase ccase on ccase.pkCPClientCase = fav.fkCPClientCase
		inner join CPJoinClientClientCase jclient on jclient.fkCPClientCase = ccase.pkCPClientCase
		inner join cpclient client on client.pkCPClient = jclient.fkCPClient
	where fav.fkApplicationUser = @pkApplicationUser 
	order by  ccase.StateCaseNumber ,ccase.pkCPClientCase,client.LastName,client.FirstName

	set nocount off

END
