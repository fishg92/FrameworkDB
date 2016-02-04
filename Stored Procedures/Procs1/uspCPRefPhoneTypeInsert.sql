----------------------------------------------------------------------------
-- Insert a single record into CPRefPhoneType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefPhoneTypeInsert]
(	  @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefPhoneType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefPhoneType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefPhoneType = SCOPE_IDENTITY()
