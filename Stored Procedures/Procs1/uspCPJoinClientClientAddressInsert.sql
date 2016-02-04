-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPJoinClientClientAddress
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinClientClientAddressInsert]
(	  @fkCPClient decimal(18, 0) = NULL
	, @fkCPClientAddress decimal(18, 0) = NULL
	, @fkCPRefClientAddressType decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinClientClientAddress decimal(18, 0) = NULL OUTPUT 
)
AS

set nocount on

exec dbo.SetAuditDataContext @LupUser, @LupMachine

--temp need to get the address type until People starts to pass in that value---------
declare @tmpAddressType decimal,
		@tmpPKJoin decimal

set @tmpAddressType = isnull(@fkCPRefClientAddressType, 0)
set @tmpPKJoin = -1

if @tmpAddressType = 0
	begin
		select @tmpAddressType = fkCPRefClientAddressType 
		from CPClientAddress
		where pkCPClientAddress = @fkCPClientAddress
	end

if isnull(@tmpAddressType, 0) = 0
	begin
		set @tmpAddressType = 1
	end
----------------------------------------------------------------------------------------

select top 1 @tmpPKJoin = pkCPJoinClientClientAddress
from CPJoinClientClientAddress
where fkCPClient = @fkCPClient
and fkCPClientAddress = @fkCPClientAddress
and isnull(fkCPRefClientAddressType, @tmpAddressType) = @tmpAddressType
order by pkCPJoinClientClientAddress desc

if isnull(@tmpPKJoin, -1) = -1
	begin
		--need to make sure the member is only attached to one address of any given address type----------------------------------------
		declare @pkJoinToDelete decimal

		select @pkJoinToDelete = pkCPJoinClientClientAddress 
		from CPJoinClientClientAddress
	    where fkCPClient = @fkCPClient 
		and fkCPRefClientAddressType = @tmpAddressType

		while isnull(@pkJoinToDelete, -1) <> -1
			begin
				exec uspCPJoinClientClientAddressDelete @pkJoinToDelete, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
				set @pkJoinToDelete = null

				select @pkJoinToDelete = pkCPJoinClientClientAddress 
				from CPJoinClientClientAddress
				where fkCPClient = @fkCPClient 
				and fkCPRefClientAddressType = @tmpAddressType
			end 
		---------------------------------------------------------------------------------------------------------------------------------

		INSERT CPJoinClientClientAddress
		(	  fkCPClient
			, fkCPClientAddress
			, fkCPRefClientAddressType
			, LockedUser
			, LockedDate
		)
		VALUES 
		(	  @fkCPClient
			, @fkCPClientAddress
			, @tmpAddressType
			, @LockedUser
			, @LockedDate
		)

		SET @pkCPJoinClientClientAddress = SCOPE_IDENTITY()
	end
else
	begin
		SET @pkCPJoinClientClientAddress = @tmpPKJoin
	end
