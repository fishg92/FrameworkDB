----------------------------------------------------------------------------
-- Update a single record in CPRefClientRelationshipType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientRelationshipTypeUpdate]
(	  @pkCPRefClientRelationshipType decimal(18, 0)
	, @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @LetterAssignment varchar(5)
	, @LetterAssignmentFont varchar(50)
	, @LetterAssignmentFontIsBold bit
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefClientRelationshipType
SET	Description = ISNULL(@Description, Description),
    LetterAssignment = ISNULL(@LetterAssignment, LetterAssignment),
	LetterAssignmentFont = ISNULL(@LetterAssignmentFont, LetterAssignmentFont),
	LetterAssignmentFontIsBold = ISNULL(@LetterAssignmentFontIsBold, LetterAssignmentFontIsBold)
WHERE 	pkCPRefClientRelationshipType = @pkCPRefClientRelationshipType
