

CREATE proc [dbo].[InsertRecipientPoolTickListItem]
(
	  @pkRecipientPool decimal(18,0)
    , @fkApplicationUser decimal(18,0)
    , @TickListIndex int
   	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)

as


exec dbo.SetAuditDataContext @LupUser, @LupMachine

insert into JoinRecipientPoolTickListItem
(fkRecipientPool, fkApplicationUser, TickListIndex)
VALUES
(@pkRecipientPool, @fkApplicationUser, @TickListIndex)
