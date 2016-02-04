----------------------------------------------------------------------------
-- Select a single record from FormPeerReviewNote
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormPeerReviewNoteSelect]
(	@pkFormPeerReviewNote decimal(18, 0) = NULL,
	@fkQuickListFormName decimal(18, 0) = NULL,
	@Note varchar(255) = NULL,
	@PageNumber int = NULL,
	@X int = NULL,
	@Y int = NULL
)
AS

SELECT	pkFormPeerReviewNote,
	fkQuickListFormName,
	Note,
	PageNumber,
	X,
	Y
FROM	FormPeerReviewNote
WHERE 	(@pkFormPeerReviewNote IS NULL OR pkFormPeerReviewNote = @pkFormPeerReviewNote)
 AND 	(@fkQuickListFormName IS NULL OR fkQuickListFormName = @fkQuickListFormName)
 AND 	(@Note IS NULL OR Note LIKE @Note + '%')
 AND 	(@PageNumber IS NULL OR PageNumber = @PageNumber)
 AND 	(@X IS NULL OR X = @X)
 AND 	(@Y IS NULL OR Y = @Y)


