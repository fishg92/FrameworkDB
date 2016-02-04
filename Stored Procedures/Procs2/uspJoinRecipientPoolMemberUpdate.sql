----------------------------------------------------------------------------
-- Update a single record in JoinRecipientPoolMember
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinRecipientPoolMemberUpdate]
(	  @pkJoinRecipientPoolMember decimal(18, 0)
	, @fkRecipientPool decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinRecipientPoolMember
SET	fkRecipientPool = ISNULL(@fkRecipientPool, fkRecipientPool),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser)
WHERE 	pkJoinRecipientPoolMember = @pkJoinRecipientPoolMember
