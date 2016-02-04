-- Stored Procedure

----------------------------------------------------------------------------
-- Save changes to a single JoinApplicationUserProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserProgramTypeSave]
(	  
	@UserName varchar(50) = NULL
	, @fkProgramType decimal(18, 0) = NULL
	, @isSelected bit = 0
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DECLARE @fkAppUser decimal(18, 0)
SET @fkAppUser = (select top 1 dbo.ApplicationUser.pkApplicationUser 
				from  ApplicationUser   with (NOLOCK) 
				where upper(Username) = upper(@UserName))
IF @isSelected = 1
BEGIN
	INSERT INTO JoinApplicationUserProgramType(fkApplicationUser, fkProgramType)
	VALUES (@fkAppUser, @fkProgramType)
END
ELSE
BEGIN
	DELETE FROM JoinApplicationUserProgramType
	WHERE fkApplicationUser = @fkAppUser AND fkProgramType = @fkProgramType
END
