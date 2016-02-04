-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in NCPSystem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNCPSystemUpdate]
(	  @pkNCPSystem int
	, @Class varchar(50) = NULL
	, @Attribute varchar(50) = NULL
	, @AttributeValue varchar(255) = NULL
	, @LUPUser varchar(50)	
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15))
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	NCPSystem
SET	Class = ISNULL(@Class, Class),
	Attribute = ISNULL(@Attribute, Attribute),
	AttributeValue = ISNULL(@AttributeValue, AttributeValue)
WHERE 	pkNCPSystem = @pkNCPSystem
