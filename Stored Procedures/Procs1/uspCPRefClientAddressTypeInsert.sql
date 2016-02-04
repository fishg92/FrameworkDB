----------------------------------------------------------------------------
-- Insert a single record into CPRefClientAddressType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefClientAddressTypeInsert]
(	  @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefClientAddressType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefClientAddressType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefClientAddressType = SCOPE_IDENTITY()
