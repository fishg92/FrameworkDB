-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPJoinClientAlertFlagTypeNT
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinClientAlertFlagTypeNTInsert]
(	  @fkCPClient decimal(18, 0) = NULL
	, @fkRefCPAlertFlagTypeNT decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinClientAlertFlagTypeNT decimal(18, 0) = NULL OUTPUT 
)
AS

set nocount on
declare @tmppkCPJoinClientAlertFlagTypeNT decimal
set @tmppkCPJoinClientAlertFlagTypeNT = 0

select @tmppkCPJoinClientAlertFlagTypeNT = pkCPJoinClientAlertFlagTypeNT
from CPJoinClientAlertFlagTypeNT
where fkCPClient = @fkCPClient 
and fkRefCPAlertFlagTypeNT = @fkRefCPAlertFlagTypeNT

if @tmppkCPJoinClientAlertFlagTypeNT = 0 
	begin

		exec dbo.SetAuditDataContext @LupUser, @LupMachine

		INSERT CPJoinClientAlertFlagTypeNT
		(	  fkCPClient
			, fkRefCPAlertFlagTypeNT
			, LockedUser
			, LockedDate
		)
		VALUES 
		(	  @fkCPClient
			, @fkRefCPAlertFlagTypeNT
			, @LockedUser
			, @LockedDate

		)

		SET @pkCPJoinClientAlertFlagTypeNT = SCOPE_IDENTITY()
	end
else
	begin
		set @pkCPJoinClientAlertFlagTypeNT = @tmppkCPJoinClientAlertFlagTypeNT
	end
