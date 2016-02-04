----------------------------------------------------------------------------
-- Insert a single record into CPClientExternalID
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientExternalIDInsert]
(	  @fkCPClient decimal(18, 0)
	, @ExternalSystemName varchar(50)
	, @ExternalSystemID varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPClientExternalID decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPClientExternalID
(	  fkCPClient
	, ExternalSystemName
	, ExternalSystemID
)
VALUES 
(	  @fkCPClient
	, @ExternalSystemName
	, @ExternalSystemID

)

SET @pkCPClientExternalID = SCOPE_IDENTITY()
