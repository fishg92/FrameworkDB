----------------------------------------------------------------------------
-- Update a single record in Language
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLanguageUpdate]
(	  @pkLanguage decimal(18, 0)
	, @Description varchar(50) = NULL
	, @Active bit = NULL
	, @DisplayText nvarchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Language
SET	Description = ISNULL(@Description, Description),
	Active = ISNULL(@Active, Active),
	DisplayText = ISNULL(@DisplayText, DisplayText)
WHERE 	pkLanguage = @pkLanguage
