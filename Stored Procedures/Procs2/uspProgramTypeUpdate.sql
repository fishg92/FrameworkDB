----------------------------------------------------------------------------
-- Update a single record in ProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProgramTypeUpdate]
(	  @pkProgramType decimal(18, 0)
	, @ProgramType varchar(50) = NULL
	, @ExternalName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ProgramType
SET	ProgramType = ISNULL(@ProgramType, ProgramType),
	ExternalName = ISNULL(@ExternalName, ExternalName)
WHERE 	pkProgramType = @pkProgramType
