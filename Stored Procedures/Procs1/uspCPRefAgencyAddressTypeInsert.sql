----------------------------------------------------------------------------
-- Insert a single record into CPRefAgencyAddressType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefAgencyAddressTypeInsert]
(	  @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefAgencyAddressType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefAgencyAddressType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefAgencyAddressType = SCOPE_IDENTITY()
