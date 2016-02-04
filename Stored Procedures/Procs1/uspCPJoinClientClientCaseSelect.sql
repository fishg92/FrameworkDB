----------------------------------------------------------------------------
-- Select a single record from CPJoinClientClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientClientCaseSelect]
(	@pkCPJoinClientClientCase decimal(18, 0) = NULL,
	@fkCPClientCase decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@PrimaryParticipantOnCase tinyint = NULL,
	@fkCPRefClientRelationshipType decimal(18, 0) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPJoinClientClientCase,
	fkCPClientCase,
	fkCPClient,
	PrimaryParticipantOnCase,
	fkCPRefClientRelationshipType,
	LockedUser,
	LockedDate
FROM	CPJoinClientClientCase
WHERE 	(@pkCPJoinClientClientCase IS NULL OR pkCPJoinClientClientCase = @pkCPJoinClientClientCase)
 AND 	(@fkCPClientCase IS NULL OR fkCPClientCase = @fkCPClientCase)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@PrimaryParticipantOnCase IS NULL OR PrimaryParticipantOnCase = @PrimaryParticipantOnCase)
 AND 	(@fkCPRefClientRelationshipType IS NULL OR fkCPRefClientRelationshipType = @fkCPRefClientRelationshipType)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)

