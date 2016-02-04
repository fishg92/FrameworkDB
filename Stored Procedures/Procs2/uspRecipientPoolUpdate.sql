----------------------------------------------------------------------------
-- Update a single record in RecipientPool
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspRecipientPoolUpdate]
(	  @pkRecipientPool decimal(18, 0)
	, @Name varchar(100) = NULL
	, @PreviousTickListIndexUsed int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	RecipientPool
SET	Name = ISNULL(@Name, Name),
	PreviousTickListIndexUsed = ISNULL(@PreviousTickListIndexUsed, PreviousTickListIndexUsed)
WHERE 	pkRecipientPool = @pkRecipientPool
