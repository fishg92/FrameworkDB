-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in JoinApplicationUserRefProfile
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserRefProfileUpdate]
(	  @pkJoinApplicationUserRefProfile decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkProfile decimal(18, 0) = NULL
	, @AppId int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	dbo.JoinApplicationUserRefProfile
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkProfile = ISNULL(@fkProfile, fkProfile),
	AppId = ISNULL(@AppId, AppId)
WHERE 	pkJoinApplicationUserRefProfile = @pkJoinApplicationUserRefProfile
