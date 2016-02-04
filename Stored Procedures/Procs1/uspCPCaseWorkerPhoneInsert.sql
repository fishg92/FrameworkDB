----------------------------------------------------------------------------
-- Insert a single record into CPCaseWorkerPhone
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPCaseWorkerPhoneInsert]
(	  @fkCPRefPhoneType decimal(18, 0) = NULL
	, @Number varchar(10) = NULL
	, @Extension varchar(10) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPCaseWorkerPhone decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPCaseWorkerPhone
(	  fkCPRefPhoneType
	, Number
	, Extension
)
VALUES 
(	  @fkCPRefPhoneType
	, @Number
	, @Extension

)

SET @pkCPCaseWorkerPhone = SCOPE_IDENTITY()
