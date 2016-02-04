----------------------------------------------------------------------------
-- Update a single record in ProvisionalAssignment
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProvisionalAssignmentUpdate]
(	  @pkProvisionalAssignment decimal(18, 0)
	, @fkRecipientPool decimal(18, 0) = NULL
	, @fkSuggestedUser decimal(18, 0) = NULL
	, @fkAssigningUser decimal(18, 0) = NULL
	, @SuggestionAccepted bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ProvisionalAssignment
SET	fkRecipientPool = ISNULL(@fkRecipientPool, fkRecipientPool),
	fkSuggestedUser = ISNULL(@fkSuggestedUser, fkSuggestedUser),
	fkAssigningUser = ISNULL(@fkAssigningUser, fkAssigningUser),
	SuggestionAccepted = ISNULL(@SuggestionAccepted, SuggestionAccepted)
WHERE 	pkProvisionalAssignment = @pkProvisionalAssignment
