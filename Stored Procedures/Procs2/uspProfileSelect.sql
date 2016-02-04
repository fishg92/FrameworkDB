----------------------------------------------------------------------------
-- Select a single record from Profile
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProfileSelect]
(	@pkProfile decimal(18, 0) = NULL,
	@Description varchar(100) = NULL,
	@LongDescription varchar(255) = NULL,	
	@fkrefTaskOrigin decimal(18, 0) = NULL,
	@RecipientMappingKeywordType varchar(50) = NULL,
	@SendDocumentToWorkflow bit = NULL
)
AS

SELECT	pkProfile,
	Description,
	LongDescription,	
	fkrefTaskOrigin,
	RecipientMappingKeywordType,
	SendDocumentToWorkflow
FROM	Profile
WHERE 	(@pkProfile IS NULL OR pkProfile = @pkProfile)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@LongDescription IS NULL OR LongDescription LIKE @LongDescription + '%')
 AND 	(@fkrefTaskOrigin IS NULL OR fkrefTaskOrigin = @fkrefTaskOrigin)
 AND 	(@RecipientMappingKeywordType IS NULL OR RecipientMappingKeywordType LIKE @RecipientMappingKeywordType + '%')
 AND 	(@SendDocumentToWorkflow IS NULL OR SendDocumentToWorkflow = @SendDocumentToWorkflow)

