-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into DocumentJoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentJoinProgramTypeDocumentTypeInsert]
(	  @fkProgramType decimal(18, 0)
	, @fkDocumentType varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkDocumentJoinProgramTypeDocumentType decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentJoinProgramTypeDocumentType
(	  fkProgramType
	, fkDocumentType
)
VALUES 
(	  @fkProgramType
	, @fkDocumentType

)

SET @pkDocumentJoinProgramTypeDocumentType = SCOPE_IDENTITY()
