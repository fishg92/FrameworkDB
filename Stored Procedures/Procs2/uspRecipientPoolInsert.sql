----------------------------------------------------------------------------
-- Insert a single record into RecipientPool
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspRecipientPoolInsert]
(	  @Name varchar(100)
	, @PreviousTickListIndexUsed int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkRecipientPool decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT RecipientPool
(	  Name
	, PreviousTickListIndexUsed
)
VALUES 
(	  @Name
	, COALESCE(@PreviousTickListIndexUsed, (-1))

)

SET @pkRecipientPool = SCOPE_IDENTITY()
