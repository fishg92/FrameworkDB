----------------------------------------------------------------------------
-- Insert a single record into CPRefMarraigeEndType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefMarraigeEndTypeInsert]
(	  @Description varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefMarraigeEndType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefMarraigeEndType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefMarraigeEndType = SCOPE_IDENTITY()
