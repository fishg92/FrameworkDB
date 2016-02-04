-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinProgramTypeDocumentTypeInsert]
(	  @fkProgramType decimal(10, 0)
	, @fkDocumentType varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkJoinProgramTypeDocumentType decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinProgramTypeDocumentType
(	  fkProgramType
	, fkDocumentType
)
VALUES 
(	  @fkProgramType
	, @fkDocumentType

)

SET @pkJoinProgramTypeDocumentType = SCOPE_IDENTITY()
