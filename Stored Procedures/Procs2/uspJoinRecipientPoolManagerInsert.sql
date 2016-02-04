----------------------------------------------------------------------------
-- Insert a single record into JoinRecipientPoolManager
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinRecipientPoolManagerInsert]
(	  @fkRecipientPool decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinRecipientPoolManager decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinRecipientPoolManager
(	  fkRecipientPool
	, fkApplicationUser
)
VALUES 
(	  @fkRecipientPool
	, @fkApplicationUser

)

SET @pkJoinRecipientPoolManager = SCOPE_IDENTITY()
