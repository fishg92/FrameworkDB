CREATE proc [dbo].[SaveUserSessionKeywords]
	@fkApplicationUser decimal
	,@KeywordList varbinary(max)
as

update	DocumentKeywordCache
set		KeywordList = @KeywordList
		,LastRefresh = getdate()
		,RefreshStarted = null
where	fkApplicationUser = @fkApplicationUser

if @@rowcount = 0
	begin
	insert	DocumentKeywordCache
			(
				fkApplicationUser
				,KeywordList
				,LastRefresh
				,RefreshStarted
			)
		values
			(
				@fkApplicationUser
				,@KeywordList
				,getdate()
				,null
			)
	end		
