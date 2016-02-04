----------------------------------------------------------------------------
-- Insert a single record into FormPeerReviewNote
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormPeerReviewNoteInsert]
(	  @fkQuickListFormName decimal(18, 0)
	, @Note varchar(255)
	, @PageNumber int
	, @X int
	, @Y int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormPeerReviewNote decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormPeerReviewNote
(	  fkQuickListFormName
	, Note
	, PageNumber
	, X
	, Y
)
VALUES 
(	  @fkQuickListFormName
	, @Note
	, @PageNumber
	, @X
	, @Y

)

SET @pkFormPeerReviewNote = SCOPE_IDENTITY()
