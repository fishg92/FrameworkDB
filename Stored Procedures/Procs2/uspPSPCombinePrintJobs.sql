CREATE PROCEDURE [dbo].[uspPSPCombinePrintJobs]
(
	  @pkCurrentPSPPrintJob decimal(18,0)
	, @pkNewPSPPrintJob decimal(18,0)
	, @PageNumberOffset int
)
AS

UPDATE PSPPrintJobPage 
SET   PageNumber = (PageNumber + @PageNumberOffset)
	, fkPSPPrintJob = @pkNewPSPPrintJob
	
WHERE fkPSPPrintJob = @pkCurrentPSPPrintJob

DECLARE @newExpectedPageCount int
SET @newExpectedPageCount = (SELECT COUNT(fkPSPPrintJob)
							FROM PSPPrintJobPage
							WHERE fkPSPPrintJob = @pkNewPSPPrintJob)

UPDATE PSPPrintJob
SET ExpectedPageCount = @newExpectedPageCount
WHERE pkPSPPrintJob = @pkNewPSPPrintJob