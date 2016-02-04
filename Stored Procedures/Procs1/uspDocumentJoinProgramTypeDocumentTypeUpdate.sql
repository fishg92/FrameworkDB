-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in DocumentJoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentJoinProgramTypeDocumentTypeUpdate]
(	  @pkDocumentJoinProgramTypeDocumentType decimal(18, 0)
	, @fkProgramType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentJoinProgramTypeDocumentType
SET	fkProgramType = ISNULL(@fkProgramType, fkProgramType),
	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType)
WHERE 	pkDocumentJoinProgramTypeDocumentType = @pkDocumentJoinProgramTypeDocumentType
