----------------------------------------------------------------------------
-- Select a single record from ProvisionalAssignment
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProvisionalAssignmentSelect]
(	@pkProvisionalAssignment decimal(18, 0) = NULL,
	@fkRecipientPool decimal(18, 0) = NULL,
	@fkSuggestedUser decimal(18, 0) = NULL,
	@fkAssigningUser decimal(18, 0) = NULL,
	@SuggestionAccepted bit = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkProvisionalAssignment,
	fkRecipientPool,
	fkSuggestedUser,
	fkAssigningUser,
	SuggestionAccepted,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	ProvisionalAssignment
WHERE 	(@pkProvisionalAssignment IS NULL OR pkProvisionalAssignment = @pkProvisionalAssignment)
 AND 	(@fkRecipientPool IS NULL OR fkRecipientPool = @fkRecipientPool)
 AND 	(@fkSuggestedUser IS NULL OR fkSuggestedUser = @fkSuggestedUser)
 AND 	(@fkAssigningUser IS NULL OR fkAssigningUser = @fkAssigningUser)
 AND 	(@SuggestionAccepted IS NULL OR SuggestionAccepted = @SuggestionAccepted)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

