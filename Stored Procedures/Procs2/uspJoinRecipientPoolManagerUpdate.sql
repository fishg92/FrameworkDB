----------------------------------------------------------------------------
-- Update a single record in JoinRecipientPoolManager
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinRecipientPoolManagerUpdate]
(	  @pkJoinRecipientPoolManager decimal(18, 0)
	, @fkRecipientPool decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinRecipientPoolManager
SET	fkRecipientPool = ISNULL(@fkRecipientPool, fkRecipientPool),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser)
WHERE 	pkJoinRecipientPoolManager = @pkJoinRecipientPoolManager
