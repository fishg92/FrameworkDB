

----------------------------------------------------------------------------
-- Update a single record in CPRefAlertFlagTypeNT
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefAlertFlagTypeNTUpdate]
(	  @pkCPRefAlertFlagTypeNT decimal(18, 0)
	, @Description varchar(255) = NULL
	, @AlertDisplay bit = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefAlertFlagTypeNT
SET	Description = ISNULL(@Description, Description),
	AlertDisplay = ISNULL(@AlertDisplay, AlertDisplay),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate)
WHERE 	pkCPRefAlertFlagTypeNT = @pkCPRefAlertFlagTypeNT
