


----------------------------------------------------------------------------
-- Select a single record from CPRefAlertFlagTypeNT
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefAlertFlagTypeNTSelect]
(	@pkCPRefAlertFlagTypeNT decimal(18, 0) = NULL,
	@Description varchar(255) = NULL,
	@AlertDisplay bit = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL)
AS

SELECT	pkCPRefAlertFlagTypeNT,
		Description,
		AlertDisplay
FROM	CPRefAlertFlagTypeNT
WHERE 	(@pkCPRefAlertFlagTypeNT IS NULL OR pkCPRefAlertFlagTypeNT = @pkCPRefAlertFlagTypeNT)
 AND 	(@Description IS NULL OR Description LIKE Description + '%')
 AND 	(@AlertDisplay IS NULL OR AlertDisplay = @AlertDisplay)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)



