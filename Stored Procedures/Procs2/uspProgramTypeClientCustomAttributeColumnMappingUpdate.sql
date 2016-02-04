----------------------------------------------------------------------------
-- Update a single record in ProgramTypeClientCustomAttributeColumnMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProgramTypeClientCustomAttributeColumnMappingUpdate]
(	  @pkProgramTypeClientCustomAttributeColumnMapping decimal(18, 0)
	, @fkProgramType decimal(18, 0) = NULL
	, @ClientCustomAttributeColumn varchar(200) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ProgramTypeClientCustomAttributeColumnMapping
SET	fkProgramType = ISNULL(@fkProgramType, fkProgramType),
	ClientCustomAttributeColumn = ISNULL(@ClientCustomAttributeColumn, ClientCustomAttributeColumn)
WHERE 	pkProgramTypeClientCustomAttributeColumnMapping = @pkProgramTypeClientCustomAttributeColumnMapping
