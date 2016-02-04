-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinrefRoleProfile
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinrefRoleProfileInsert]
(	  @fkrefRole decimal(18, 0)
	, @fkProfile decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkJoinrefRoleProfile decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinrefRoleProfile
(	  fkrefRole
	, fkProfile
)
VALUES 
(	  @fkrefRole
	, @fkProfile

)

SET @pkJoinrefRoleProfile = SCOPE_IDENTITY()
