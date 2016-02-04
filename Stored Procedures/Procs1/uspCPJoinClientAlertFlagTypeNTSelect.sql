
----------------------------------------------------------------------------
-- Select a single record from CPJoinClientAlertFlagTypeNT
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientAlertFlagTypeNTSelect]
(	@pkCPJoinClientAlertFlagTypeNT decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkRefCPAlertFlagTypeNT decimal(18, 0) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPJoinClientAlertFlagTypeNT,
	fkCPClient,
	fkRefCPAlertFlagTypeNT,
	LockedUser,
	LockedDate
FROM	CPJoinClientAlertFlagTypeNT
WHERE 	(@pkCPJoinClientAlertFlagTypeNT IS NULL OR pkCPJoinClientAlertFlagTypeNT = @pkCPJoinClientAlertFlagTypeNT)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkRefCPAlertFlagTypeNT IS NULL OR fkRefCPAlertFlagTypeNT = @fkRefCPAlertFlagTypeNT)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)


