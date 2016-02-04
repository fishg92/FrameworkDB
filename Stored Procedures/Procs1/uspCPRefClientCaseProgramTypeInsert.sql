----------------------------------------------------------------------------
-- Insert a single record into CPRefClientCaseProgramType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefClientCaseProgramTypeInsert]
(	  @Description varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefClientCaseProgramType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefClientCaseProgramType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefClientCaseProgramType = SCOPE_IDENTITY()
