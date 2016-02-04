-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into RefCredentialType
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefCredentialTypeInsert]
(	  @Description varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkRefCredentialType decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT RefCredentialType
(	  Description
)
VALUES 
(	  @Description

)

SET @pkRefCredentialType = SCOPE_IDENTITY()
