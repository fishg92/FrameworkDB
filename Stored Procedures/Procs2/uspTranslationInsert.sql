----------------------------------------------------------------------------
-- Insert a single record into Translation
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTranslationInsert]
(	  @fkScreenControl decimal(18, 0)
	, @fkLanguage decimal(18, 0)
	, @Description varchar(500) = NULL
	, @DisplayText nvarchar(1000)
	, @Context varchar(50) = NULL
	, @Sequence int = NULL
	, @ItemKey varchar(200) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTranslation decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Translation
(	  fkScreenControl
	, fkLanguage
	, Description
	, DisplayText
	, Context
	, Sequence
	, ItemKey
)
VALUES 
(	  @fkScreenControl
	, @fkLanguage
	, COALESCE(@Description, '')
	, @DisplayText
	, COALESCE(@Context, '')
	, @Sequence
	, @ItemKey

)

SET @pkTranslation = SCOPE_IDENTITY()
