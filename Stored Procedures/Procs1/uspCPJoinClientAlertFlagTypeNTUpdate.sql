
----------------------------------------------------------------------------
-- Update a single record in CPJoinClientAlertFlagTypeNT
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientAlertFlagTypeNTUpdate]
(	  @pkCPJoinClientAlertFlagTypeNT decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkRefCPAlertFlagTypeNT decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE	CPJoinClientAlertFlagTypeNT
	SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
		fkRefCPAlertFlagTypeNT = ISNULL(@fkRefCPAlertFlagTypeNT, fkRefCPAlertFlagTypeNT),
		LockedUser = ISNULL(@LockedUser, LockedUser),
		LockedDate = ISNULL(@LockedDate, LockedDate)
	WHERE 	pkCPJoinClientAlertFlagTypeNT = @pkCPJoinClientAlertFlagTypeNT
