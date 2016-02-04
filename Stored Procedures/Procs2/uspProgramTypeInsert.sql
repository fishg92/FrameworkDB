----------------------------------------------------------------------------
-- Insert a single record into ProgramType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProgramTypeInsert]
(	  @ProgramType varchar(50)
	, @ExternalName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkProgramType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ProgramType
(	  ProgramType
	, ExternalName
)
VALUES 
(	  @ProgramType
	, @ExternalName

)

SET @pkProgramType = SCOPE_IDENTITY()
