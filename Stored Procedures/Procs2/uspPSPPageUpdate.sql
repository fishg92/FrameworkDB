----------------------------------------------------------------------------
-- Update a single record in PSPPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPageUpdate]
(	  @pkPSPPage decimal(18, 0)
	, @fkPSPDocType decimal(18, 0) = NULL
	, @PageNumber int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPPage
SET	fkPSPDocType = ISNULL(@fkPSPDocType, fkPSPDocType),
	PageNumber = ISNULL(@PageNumber, PageNumber)
WHERE 	pkPSPPage = @pkPSPPage
