----------------------------------------------------------------------------
-- Insert a single record into JoinRecipientPoolMember
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinRecipientPoolMemberInsert]
(	  @fkRecipientPool decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinRecipientPoolMember decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinRecipientPoolMember
(	  fkRecipientPool
	, fkApplicationUser
)
VALUES 
(	  @fkRecipientPool
	, @fkApplicationUser

)

SET @pkJoinRecipientPoolMember = SCOPE_IDENTITY()
