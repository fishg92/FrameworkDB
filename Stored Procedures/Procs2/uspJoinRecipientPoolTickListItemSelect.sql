----------------------------------------------------------------------------
-- Select a single record from JoinRecipientPoolTickListItem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinRecipientPoolTickListItemSelect]
(	@pkJoinRecipientPoolTickListItem decimal(18, 0) = NULL,
	@fkRecipientPool decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@TickListIndex int = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkJoinRecipientPoolTickListItem,
	fkRecipientPool,
	fkApplicationUser,
	TickListIndex,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	JoinRecipientPoolTickListItem
WHERE 	(@pkJoinRecipientPoolTickListItem IS NULL OR pkJoinRecipientPoolTickListItem = @pkJoinRecipientPoolTickListItem)
 AND 	(@fkRecipientPool IS NULL OR fkRecipientPool = @fkRecipientPool)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@TickListIndex IS NULL OR TickListIndex = @TickListIndex)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

