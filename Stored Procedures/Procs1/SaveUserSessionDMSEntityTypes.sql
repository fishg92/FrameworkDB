create proc [dbo].[SaveUserSessionDMSEntityTypes]
	@fkApplicationUser decimal
	,@EntityTypes varbinary(max)
as

update	DMSEntityTypeCache
set		DMSTypes = @EntityTypes
		,LastRefresh = getdate()
		,RefreshStarted = null
where	fkApplicationUser = @fkApplicationUser

if @@rowcount = 0
	begin
	insert	DMSEntityTypeCache
			(
				fkApplicationUser
				,DMSTypes
				,LastRefresh
				,RefreshStarted
			)
		values
			(
				@fkApplicationUser
				,@EntityTypes
				,getdate()
				,null
			)
	end		
