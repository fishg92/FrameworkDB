----------------------------------------------------------------------------
-- Select a single record from JoinRecipientPoolManager
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinRecipientPoolManagerSelect]
(	@pkJoinRecipientPoolManager decimal(18, 0) = NULL,
	@fkRecipientPool decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkJoinRecipientPoolManager,
	fkRecipientPool,
	fkApplicationUser,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	JoinRecipientPoolManager
WHERE 	(@pkJoinRecipientPoolManager IS NULL OR pkJoinRecipientPoolManager = @pkJoinRecipientPoolManager)
 AND 	(@fkRecipientPool IS NULL OR fkRecipientPool = @fkRecipientPool)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)