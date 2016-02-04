CREATE PROCEDURE [dbo].[uspCPImportJoinClientCase]
(
	  @fkCPClient decimal (18,0)
	, @fkCPClientCase decimal (18,0)
	, @PrimaryParticipantOnCase tinyint
	, @pkCPJoinClientClientCase decimal (18,0) = NULL output
)
AS

SET NOCOUNT ON

DECLARE   @HostName varchar(100)
		, @PrimaryParticipantOnCaseCurrent decimal
		
SELECT @HostName = HOST_NAME()
SELECT @pkCPJoinClientClientCase = 0

SELECT @pkCPJoinClientClientCase = pkCPJoinClientClientCase
	 , @PrimaryParticipantOnCaseCurrent = PrimaryParticipantOnCase
FROM CPJoinClientClientCase j (NOLOCK)
WHERE j.fkCPClient = @fkCPClient
AND j.fkCPClientCase = @fkCPClientCase

IF @pkCPJoinClientClientCase <> 0
BEGIN
	IF @PrimaryParticipantOnCaseCurrent <> @PrimaryParticipantOnCase 
	BEGIN
		EXEC dbo.uspCPJoinClientClientCaseUpdate  @pkCPJoinClientClientCase = @pkCPJoinClientClientCase
												, @fkCPClientCase = @fkCPClientCase
												, @fkCPClient = @fkCPClient
												, @PrimaryParticipantOnCase = @PrimaryParticipantOnCase
												, @fkCPRefClientRelationshipType = NULL
												, @LUPUser = @HostName
												, @LUPMac = @HostName
												, @LUPIP = @HostName
												, @LUPMachine = @HostName
	END
END
ELSE
BEGIN
	EXEC dbo.uspCPJoinClientClientCaseInsert  @fkCPClientCase = @fkCPClientCase
											, @fkCPClient = @fkCPClient
											, @PrimaryParticipantOnCase = @PrimaryParticipantOnCase
											, @fkCPRefClientRelationshipType = NULL
											, @LUPUser = @HostName
											, @LUPMac = @HostName
											, @LUPIP = @HostName
											, @LUPMachine = @HostName
											, @pkCPJoinClientClientCase = @pkCPJoinClientClientCase output
END