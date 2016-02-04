create proc OBUserSessionDelete
	@OBUserName varchar(50)
as

delete OBUserSession
where OBUserName = @OBUserName
