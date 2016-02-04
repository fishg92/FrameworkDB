----------------------------------------------------------------------------
-- Select a single record from CPCaseWorkerAltId
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseWorkerAltIdSelect]
(	@pkCPCaseWorkerAltId decimal(18, 0) = NULL,
	@fkCPCaseWorker decimal(18, 0) = NULL,
	@WorkerId varchar(50) = NULL,
	@LockedDate datetime = NULL,
	@LockedUser varchar(50) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL
)
AS

SELECT	pkCPCaseWorkerAltId,
	fkCPCaseWorker,
	WorkerId,
	LockedDate,
	LockedUser
	fkApplicationUser
FROM	CPCaseWorkerAltId
WHERE 	(@pkCPCaseWorkerAltId IS NULL OR pkCPCaseWorkerAltId = @pkCPCaseWorkerAltId)
 AND 	(@fkCPCaseWorker IS NULL OR fkCPCaseWorker = @fkCPCaseWorker)
 AND 	(@WorkerId IS NULL OR WorkerId LIKE @WorkerId + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)

