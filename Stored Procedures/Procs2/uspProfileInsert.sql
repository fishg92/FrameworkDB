----------------------------------------------------------------------------
-- Insert a single record into Profile
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProfileInsert]
(	  @Description varchar(100)
	, @LongDescription varchar(255)
	, @fkrefTaskOrigin decimal(18, 0) = NULL
	, @RecipientMappingKeywordType varchar(50) = NULL
	, @SendDocumentToWorkflow bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkProfile decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Profile
(	  Description
	, LongDescription
	, fkrefTaskOrigin
	, RecipientMappingKeywordType
	, SendDocumentToWorkflow
)
VALUES 
(	  @Description
	, @LongDescription
	, COALESCE(@fkrefTaskOrigin, (-1))
	, COALESCE(@RecipientMappingKeywordType, '')
	, COALESCE(@SendDocumentToWorkflow, (0))

)

SET @pkProfile = SCOPE_IDENTITY()
