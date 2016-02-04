----------------------------------------------------------------------------
-- Select a single record from CPRefClientRelationshipType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientRelationshipTypeSelect]
(	@pkCPRefClientRelationshipType decimal(18, 0) = NULL,
	@Description varchar(255) = NULL,
	@LetterAssignment varchar(5) = NULL,
	@LetterAssignmentFont varchar(50) = NULL,
	@LetterAssignmentFontIsBold bit = NULL
)
AS

SELECT	pkCPRefClientRelationshipType,
	Description,
	LetterAssignment,
	LetterAssignmentFont,
	LetterAssignmentFontIsBold
FROM	CPRefClientRelationshipType
WHERE 	(@pkCPRefClientRelationshipType IS NULL OR pkCPRefClientRelationshipType = @pkCPRefClientRelationshipType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@LetterAssignment IS NULL OR LetterAssignment LIKE @LetterAssignment + '%')
 AND 	(@LetterAssignmentFont IS NULL OR LetterAssignmentFont LIKE @LetterAssignmentFont + '%')
 AND 	(@LetterAssignmentFontIsBold IS NULL OR LetterAssignmentFontIsBold = @LetterAssignmentFontIsBold)
