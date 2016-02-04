----------------------------------------------------------------------------
-- Update a single record in CPClientExternalID
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientExternalIDUpdate]
(	  @pkCPClientExternalID decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @ExternalSystemName varchar(50) = NULL
	, @ExternalSystemID varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientExternalID
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	ExternalSystemName = ISNULL(@ExternalSystemName, ExternalSystemName),
	ExternalSystemID = ISNULL(@ExternalSystemID, ExternalSystemID)
WHERE 	pkCPClientExternalID = @pkCPClientExternalID
