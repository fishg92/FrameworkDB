----------------------------------------------------------------------------
-- Insert a single record into CPCaseActivityType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPCaseActivityTypeInsert]
(	  @Description varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPCaseActivityType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPCaseActivityType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPCaseActivityType = SCOPE_IDENTITY()
