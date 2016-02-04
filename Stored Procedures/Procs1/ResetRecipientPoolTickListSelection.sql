
CREATE PROC [dbo].[ResetRecipientPoolTickListSelection]

(
	 @fkRecipientPool decimal(18, 0)
	 , @NextTickListIndex integer
	 , @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	declare @newIndex integer

	select @newIndex = -1

	--look for the max index less than the one the user picked
	if (select count(*)  
		from JoinRecipientPoolTickListItem 
		where fkRecipientPool = @fkRecipientPool
		and TickListIndex < @NextTickListIndex) < 1
	begin 
		select @newIndex = -1
	end
	else
	begin
		select @newIndex = Max(TickListIndex) 
		from JoinRecipientPoolTickListItem 
		where fkRecipientPool = @fkRecipientPool
		and TickListIndex < @NextTickListIndex
	end 

	--if nothing was found the get the max
	if (@newIndex = -1)
		begin
			select @newIndex = Max(TickListIndex) 
			from JoinRecipientPoolTickListItem 
			where fkRecipientPool = @fkRecipientPool
		end

	
	update JoinRecipientPoolTickListItem 
	set selected = 0 
	where fkRecipientPool = @fkRecipientPool

	update JoinRecipientPoolTickListItem 
	set selected = 1 
	where TickListIndex = @newIndex
	and fkRecipientPool = @fkRecipientPool
