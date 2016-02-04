----------------------------------------------------------------------------
-- Update a single record in CPJoinClientClientAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientClientAddressUpdate]
(	  @pkCPJoinClientClientAddress decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkCPClientAddress decimal(18, 0) = NULL
	, @fkCPRefClientAddressType decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

--	declare @pkJoin decimal
--	set @pkJoin = 0
--
--	select @pkJoin = pkCPJoinClientClientAddress
--		      from CPJoinClientClientAddress
--		      where pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress
--		      and fkCPClient = @fkCPClient
--		      and fkCPClientAddress = @fkCPClientAddress
--	
--	--only update if fkclient or fkcase have changed
--	--updates affect the case activity dates so we only do it if some really has changed
--	if isnull(@pkJoin, 0) = 0
--		begin
			UPDATE	CPJoinClientClientAddress
			SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
				fkCPClientAddress = ISNULL(@fkCPClientAddress, fkCPClientAddress),
				fkCPRefClientAddressType = ISNULL(@fkCPRefClientAddressType, fkCPRefClientAddressType),
				LockedUser = ISNULL(@LockedUser, LockedUser),
				LockedDate = ISNULL(@LockedDate, LockedDate)
			WHERE 	pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress
--		end
