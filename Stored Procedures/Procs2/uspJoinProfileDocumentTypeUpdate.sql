----------------------------------------------------------------------------
-- Update a single record in JoinProfileDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileDocumentTypeUpdate]
(	  @pkJoinProfileDocumentType decimal(18, 0)
	, @fkProfile decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinProfileDocumentType
SET	fkProfile = ISNULL(@fkProfile, fkProfile),
	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType)
WHERE 	pkJoinProfileDocumentType = @pkJoinProfileDocumentType
