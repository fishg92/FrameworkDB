CREATE proc [dbo].[ClearUserSession]
	@pkApplicationUser decimal

/**************************************
@pkApplicationUser -1 clears all sessions
This line is to test Source Control. I will delete it after I force a build. -AMP
***************************************/
as

delete	DocumentDocTypeCache
where	fkApplicationUser = @pkApplicationUser
or @pkApplicationUser = -1

delete	DocumentKeywordCache
where	fkApplicationUser = @pkApplicationUser
or @pkApplicationUser = -1

delete	DMSEntityTypeCache
where	fkApplicationUser = @pkApplicationUser
or @pkApplicationUser = -1
