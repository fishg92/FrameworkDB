----------------------------------------------------------------------------
-- Insert a single record into PSPPage
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPPageInsert]
(	  @fkPSPDocType decimal(18, 0)
	, @PageNumber int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPPage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPPage
(	  fkPSPDocType
	, PageNumber
)
VALUES 
(	  @fkPSPDocType
	, @PageNumber

)

SET @pkPSPPage = SCOPE_IDENTITY()
