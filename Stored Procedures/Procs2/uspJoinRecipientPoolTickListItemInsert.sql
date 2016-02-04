----------------------------------------------------------------------------
-- Insert a single record into JoinRecipientPoolTickListItem
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinRecipientPoolTickListItemInsert]
(	  @fkRecipientPool decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @TickListIndex int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinRecipientPoolTickListItem decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinRecipientPoolTickListItem
(	  fkRecipientPool
	, fkApplicationUser
	, TickListIndex
)
VALUES 
(	  @fkRecipientPool
	, @fkApplicationUser
	, @TickListIndex

)

SET @pkJoinRecipientPoolTickListItem = SCOPE_IDENTITY()
