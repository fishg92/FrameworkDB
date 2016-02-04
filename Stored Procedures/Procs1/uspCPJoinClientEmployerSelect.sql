----------------------------------------------------------------------------
-- Select a single record from CPJoinClientEmployer
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientEmployerSelect]
(	@pkCPJoinClientEmployer decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkCPEmployer decimal(18, 0) = NULL,
	@StartDate datetime = NULL,
	@EndDate datetime = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPJoinClientEmployer,
	fkCPClient,
	fkCPEmployer,
	StartDate,
	EndDate,
	LockedUser,
	LockedDate
FROM	CPJoinClientEmployer
WHERE 	(@pkCPJoinClientEmployer IS NULL OR pkCPJoinClientEmployer = @pkCPJoinClientEmployer)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkCPEmployer IS NULL OR fkCPEmployer = @fkCPEmployer)
 AND 	(@StartDate IS NULL OR StartDate = @StartDate)
 AND 	(@EndDate IS NULL OR EndDate = @EndDate)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)

