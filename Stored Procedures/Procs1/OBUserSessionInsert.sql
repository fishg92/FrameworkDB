CREATE proc [dbo].[OBUserSessionInsert]
	@OBUserName varchar(50)
	,@SessionID varchar(50)
	,@ServiceURL varchar(100)
	,@ServiceDataSource varchar(100)
as

delete OBUserSession
where OBUserName = @OBUserName

insert OBUserSession
	(
		OBUserName
		,SessionID
		,ServiceURL
		,ServiceDataSource
	)
values
	(
		@OBUserName
		,@SessionID
		,@ServiceURL
		,@ServiceDataSource
	)
