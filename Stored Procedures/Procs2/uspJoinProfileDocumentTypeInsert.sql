----------------------------------------------------------------------------
-- Insert a single record into JoinProfileDocumentType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinProfileDocumentTypeInsert]
(	  @fkProfile decimal(18, 0)
	, @fkDocumentType varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinProfileDocumentType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinProfileDocumentType
(	  fkProfile
	, fkDocumentType
)
VALUES 
(	  @fkProfile
	, @fkDocumentType

)

SET @pkJoinProfileDocumentType = SCOPE_IDENTITY()
