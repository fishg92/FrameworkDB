----------------------------------------------------------------------------
-- Update a single record in JoinRecipientPoolTickListItem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinRecipientPoolTickListItemUpdate]
(	  @pkJoinRecipientPoolTickListItem decimal(18, 0)
	, @fkRecipientPool decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @TickListIndex int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinRecipientPoolTickListItem
SET	fkRecipientPool = ISNULL(@fkRecipientPool, fkRecipientPool),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	TickListIndex = ISNULL(@TickListIndex, TickListIndex)
WHERE 	pkJoinRecipientPoolTickListItem = @pkJoinRecipientPoolTickListItem
