----------------------------------------------------------------------------
-- Insert a single record into PSPDocImage
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPDocImageInsert]
(	  @fkPSPDocType decimal(18, 0)
	, @FullImage varbinary(MAX)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPDocImage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPDocImage
(	  fkPSPDocType
	, FullImage
)
VALUES 
(	  @fkPSPDocType
	, @FullImage

)

SET @pkPSPDocImage = SCOPE_IDENTITY()
