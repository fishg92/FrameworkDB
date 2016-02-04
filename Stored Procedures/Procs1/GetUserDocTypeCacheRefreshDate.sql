CREATE proc [dbo].[GetUserDocTypeCacheRefreshDate]
	@pkApplicationUser decimal
	,@RefreshDate datetime output
as

set @RefreshDate =  isnull((select top 1 LastRefresh
							from DMSEntityTypeCache
							where fkApplicationUser = @pkApplicationUser),convert(datetime,'1/1/1900'))