----------------------------------------------------------------------------
-- Insert a single record into Language
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspLanguageInsert]
(	  @Description varchar(50)
	, @Active bit
	, @DisplayText nvarchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkLanguage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Language
(	  pkLanguage
	, Description
	, Active
	, DisplayText
)
VALUES 
(	  @pkLanguage
	, @Description
	, @Active
	, @DisplayText

)

SET @pkLanguage = SCOPE_IDENTITY()
