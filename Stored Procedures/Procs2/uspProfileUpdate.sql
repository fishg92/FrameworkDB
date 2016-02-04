----------------------------------------------------------------------------
-- Update a single record in Profile
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProfileUpdate]
(	  @pkProfile decimal(18, 0)
	, @Description varchar(100) = NULL
	, @LongDescription varchar(255) = NULL
	, @fkrefTaskOrigin decimal(18, 0) = NULL
	, @RecipientMappingKeywordType varchar(50) = NULL
	, @SendDocumentToWorkflow bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Profile
SET	Description = ISNULL(@Description, Description),
	LongDescription = ISNULL(@LongDescription, LongDescription),
	fkrefTaskOrigin = ISNULL(@fkrefTaskOrigin, fkrefTaskOrigin),
	RecipientMappingKeywordType = ISNULL(@RecipientMappingKeywordType, RecipientMappingKeywordType),
	SendDocumentToWorkflow = ISNULL(@SendDocumentToWorkflow, SendDocumentToWorkflow)
WHERE 	pkProfile = @pkProfile
