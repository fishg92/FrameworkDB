CREATE proc [dbo].[SaveUserSessionDocTypes]
	@fkApplicationUser decimal
	,@DocTypeList varbinary(max)
as

update	DocumentDocTypeCache
set		DocTypeList = @DocTypeList
		,LastRefresh = getdate()
		,RefreshStarted = null
where	fkApplicationUser = @fkApplicationUser

if @@rowcount = 0
	begin
	insert	DocumentDocTypeCache
			(
				fkApplicationUser
				,DocTypeList
				,LastRefresh
				,RefreshStarted
			)
		values
			(
				@fkApplicationUser
				,@DocTypeList
				,getdate()
				,null
			)
	end		
