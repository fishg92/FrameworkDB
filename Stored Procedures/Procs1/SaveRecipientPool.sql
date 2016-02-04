


CREATE PROC [dbo].[SaveRecipientPool]
(	
	@pkRecipientPool decimal(18, 0) 
	,@Name varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	update RecipientPool set Name = @Name
	 where  pkRecipientPool = @pkRecipientPool
