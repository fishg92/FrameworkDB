

----------------------------------------------------------------------------
-- Insert a single record into CPRefAlertFlagTypeNT
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefAlertFlagTypeNTInsert]
(	  @Description varchar(255) = NULL
	, @AlertDisplay bit = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefAlertFlagTypeNT decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefAlertFlagTypeNT
(	  Description
	, AlertDisplay
	, LockedUser
	, LockedDate
)
VALUES 
(	  @Description
	, @AlertDisplay
	, @LockedUser
	, @LockedDate

)

SET @pkCPRefAlertFlagTypeNT = SCOPE_IDENTITY()
