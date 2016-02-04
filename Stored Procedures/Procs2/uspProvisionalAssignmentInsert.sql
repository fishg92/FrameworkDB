----------------------------------------------------------------------------
-- Insert a single record into ProvisionalAssignment
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProvisionalAssignmentInsert]
(	  @fkRecipientPool decimal(18, 0)
	, @fkSuggestedUser decimal(18, 0)
	, @fkAssigningUser decimal(18, 0)
	, @SuggestionAccepted bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkProvisionalAssignment decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ProvisionalAssignment
(	  fkRecipientPool
	, fkSuggestedUser
	, fkAssigningUser
	, SuggestionAccepted
)
VALUES 
(	  @fkRecipientPool
	, @fkSuggestedUser
	, @fkAssigningUser
	, @SuggestionAccepted

)

SET @pkProvisionalAssignment = SCOPE_IDENTITY()
