-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormPath
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormPathInsert]
(	  @fkFormName decimal(10, 0)
	, @Path varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormPath decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormPath
(	  fkFormName
	, Path
)
VALUES 
(	  @fkFormName
	, @Path

)

SET @pkFormPath = SCOPE_IDENTITY()
