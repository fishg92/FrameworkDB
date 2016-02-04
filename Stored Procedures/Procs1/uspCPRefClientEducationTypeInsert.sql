----------------------------------------------------------------------------
-- Insert a single record into CPRefClientEducationType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefClientEducationTypeInsert]
(	  @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefClientEducationType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefClientEducationType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefClientEducationType = SCOPE_IDENTITY()
