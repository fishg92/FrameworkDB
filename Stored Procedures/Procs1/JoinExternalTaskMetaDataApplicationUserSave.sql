CREATE proc [dbo].[JoinExternalTaskMetaDataApplicationUserSave]
	@fkExternalTaskMetaData decimal
	,@fkApplicationUser decimal
	,@UserRead bit
	,@UserReadNote bit = 0
	,@LUPUser varchar(50)
	,@LUPMac char(17)
	,@LUPIP varchar(15)
	,@LUPMachine varchar(15)
as

declare @pkJoinExternalTaskMetaDataApplicationUser decimal

select	@pkJoinExternalTaskMetaDataApplicationUser = pkJoinExternalTaskMetaDataApplicationUser
from	JoinExternalTaskMetaDataApplicationUser
where	fkExternalTaskMetaData = @fkExternalTaskMetaData
and		fkApplicationUser = @fkApplicationUser

if @pkJoinExternalTaskMetaDataApplicationUser is null
	begin
	exec dbo.uspJoinExternalTaskMetaDataApplicationUserInsert
		@fkExternalTaskMetaData = @fkExternalTaskMetaData
		,@fkApplicationUser = @fkApplicationUser
		,@UserRead = @UserRead
		,@UserReadNote = @UserReadNote
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end
else
	begin
	exec dbo.uspJoinExternalTaskMetaDataApplicationUserUpdate
		@pkJoinExternalTaskMetaDataApplicationUser = @pkJoinExternalTaskMetaDataApplicationUser
		,@fkExternalTaskMetaData = @fkExternalTaskMetaData
		,@fkApplicationUser = @fkApplicationUser
		,@UserRead = @UserRead
		,@UserReadNote = @UserReadNote
		,@LUPUser = @LUPUser
		,@LUPMac = @LUPMac
		,@LUPIP = @LUPIP
		,@LUPMachine = @LUPMachine
	end