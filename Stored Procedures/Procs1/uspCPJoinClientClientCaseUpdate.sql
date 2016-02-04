----------------------------------------------------------------------------
-- Update a single record in CPJoinClientClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientClientCaseUpdate]
(	  @pkCPJoinClientClientCase decimal(18, 0)
	, @fkCPClientCase decimal(18, 0) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @PrimaryParticipantOnCase tinyint = NULL
	, @fkCPRefClientRelationshipType decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPJoinClientClientCase
SET	fkCPClientCase = ISNULL(@fkCPClientCase, fkCPClientCase),
	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	PrimaryParticipantOnCase = ISNULL(@PrimaryParticipantOnCase, PrimaryParticipantOnCase),
	fkCPRefClientRelationshipType = ISNULL(@fkCPRefClientRelationshipType, fkCPRefClientRelationshipType),
	LockedUser = @LockedUser,
	LockedDate = @LockedDate
WHERE 	pkCPJoinClientClientCase = @pkCPJoinClientClientCase
