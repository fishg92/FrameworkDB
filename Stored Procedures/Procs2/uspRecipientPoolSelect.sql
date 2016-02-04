----------------------------------------------------------------------------
-- Select a single record from RecipientPool
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspRecipientPoolSelect]
(	@pkRecipientPool decimal(18, 0) = NULL,
	@Name varchar(100) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL,
	@PreviousTickListIndexUsed int = NULL
)
AS

SELECT	pkRecipientPool,
	Name,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	PreviousTickListIndexUsed
FROM	RecipientPool
WHERE 	(@pkRecipientPool IS NULL OR pkRecipientPool = @pkRecipientPool)
 AND 	(@Name IS NULL OR Name LIKE @Name + '%')
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
 AND 	(@PreviousTickListIndexUsed IS NULL OR PreviousTickListIndexUsed = @PreviousTickListIndexUsed)

