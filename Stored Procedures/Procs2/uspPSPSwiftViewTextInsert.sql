----------------------------------------------------------------------------
-- Insert a single record into PSPSwiftViewText
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPSwiftViewTextInsert]
(	  @SwiftViewText varchar(100) = NULL
	, @PageNumber int = NULL
	, @Xpos decimal(9, 3) = NULL
	, @Ypos decimal(9, 3) = NULL
	, @fkPSPDocument decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPSwiftViewText decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPSwiftViewText
(	  SwiftViewText
	, PageNumber
	, Xpos
	, Ypos
	, fkPSPDocument
)
VALUES 
(	  @SwiftViewText
	, @PageNumber
	, @Xpos
	, @Ypos
	, @fkPSPDocument

)

SET @pkPSPSwiftViewText = SCOPE_IDENTITY()
