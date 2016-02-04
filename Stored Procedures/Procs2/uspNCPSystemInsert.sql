-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into NCPSystem
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspNCPSystemInsert]
(	  @Class varchar(50) = NULL
	, @Attribute varchar(50) = NULL
	, @AttributeValue varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkNCPSystem decimal(10, 0) = NULL OUTPUT 
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT NCPSystem
(	  Class
	, Attribute
	, AttributeValue
)
VALUES 
(	  @Class
	, @Attribute
	, @AttributeValue

)

SET @pkNCPSystem = SCOPE_IDENTITY()
