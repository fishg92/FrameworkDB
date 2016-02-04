----------------------------------------------------------------------------
-- Update a single record in Translation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTranslationUpdate]
(	  @pkTranslation decimal(18, 0)
	, @fkScreenControl decimal(18, 0) = NULL
	, @fkLanguage decimal(18, 0) = NULL
	, @Description varchar(500) = NULL
	, @DisplayText nvarchar(1000) = NULL
	, @Context varchar(50) = NULL
	, @Sequence int = NULL
	, @ItemKey varchar(200) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Translation
SET	fkScreenControl = ISNULL(@fkScreenControl, fkScreenControl),
	fkLanguage = ISNULL(@fkLanguage, fkLanguage),
	Description = ISNULL(@Description, Description),
	DisplayText = ISNULL(@DisplayText, DisplayText),
	Context = ISNULL(@Context, Context),
	Sequence = ISNULL(@Sequence, Sequence),
	ItemKey = ISNULL(@ItemKey, ItemKey)
WHERE 	pkTranslation = @pkTranslation
