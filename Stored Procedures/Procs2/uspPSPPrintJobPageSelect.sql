----------------------------------------------------------------------------
-- Select a single record from PSPPrintJobPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobPageSelect]
(	@pkPSPPrintJobPage decimal(18, 0) = NULL,
	@fkPSPPrintJob decimal(18, 0) = NULL,
	@PageNumber int = NULL,
	@PageData varbinary(MAX) = NULL
)
AS

SELECT	pkPSPPrintJobPage,
	fkPSPPrintJob,
	PageNumber,
	PageData
FROM	PSPPrintJobPage
WHERE 	(@pkPSPPrintJobPage IS NULL OR pkPSPPrintJobPage = @pkPSPPrintJobPage)
 AND 	(@fkPSPPrintJob IS NULL OR fkPSPPrintJob = @fkPSPPrintJob)
 AND 	(@PageNumber IS NULL OR PageNumber = @PageNumber)

