
CREATE Proc [dbo].[InsertRecipientPool]
(	@Name varchar(100)
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
)
VALUES 
(	 @Name
)

SET @pkRecipientPool = SCOPE_IDENTITY()
