-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormPeerReviewNote
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormPeerReviewNoteUpdate]
(	  @pkFormPeerReviewNote decimal(18, 0)
	, @fkQuickListFormName decimal(18, 0) = NULL
	, @Note varchar(255) = NULL
	, @PageNumber int = NULL
	, @X int = NULL
	, @Y int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormPeerReviewNote
SET	fkQuickListFormName = ISNULL(@fkQuickListFormName, fkQuickListFormName),
	Note = ISNULL(@Note, Note),
	PageNumber = ISNULL(@PageNumber, PageNumber),
	X = ISNULL(@X, X),
	Y = ISNULL(@Y, Y)
WHERE 	pkFormPeerReviewNote = @pkFormPeerReviewNote
