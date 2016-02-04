----------------------------------------------------------------------------
-- Insert a single record into CPRefClientRelationshipType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefClientRelationshipTypeInsert]
(	  @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @LetterAssignment varchar(5)
	, @LetterAssignmentFont varchar(50)
	, @LetterAssignmentFontIsBold bit
	, @pkCPRefClientRelationshipType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefClientRelationshipType
(	  Description,
	  LetterAssignment,
	  LetterAssignmentFont,
	  LetterAssignmentFontIsBold
)
VALUES 
(	  @Description,
	  @LetterAssignment,
	  @LetterAssignmentFont,
	  @LetterAssignmentFontIsBold
)

SET @pkCPRefClientRelationshipType = SCOPE_IDENTITY()
