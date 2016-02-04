----------------------------------------------------------------------------
-- Insert a single record into ProgramTypeClientCustomAttributeColumnMapping
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProgramTypeClientCustomAttributeColumnMappingInsert]
(	  @fkProgramType decimal(18, 0)
	, @ClientCustomAttributeColumn varchar(200)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkProgramTypeClientCustomAttributeColumnMapping decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ProgramTypeClientCustomAttributeColumnMapping
(	  fkProgramType
	, ClientCustomAttributeColumn
)
VALUES 
(	  @fkProgramType
	, @ClientCustomAttributeColumn

)

SET @pkProgramTypeClientCustomAttributeColumnMapping = SCOPE_IDENTITY()
