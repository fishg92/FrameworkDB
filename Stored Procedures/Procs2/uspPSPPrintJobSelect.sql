----------------------------------------------------------------------------
-- Select a single record from PSPPrintJob
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobSelect]
(	@pkPSPPrintJob decimal(18, 0) = NULL,
	@MachineName varchar(255) = NULL,
	@Username varchar(255) = NULL,
	@PrintDate datetime = NULL,
	@DocType varchar(50) = NULL,
	@PrintJobType int = NULL,
	@ExpectedPageCount int = NULL
)
AS

SELECT	pkPSPPrintJob,
	MachineName,
	Username,
	PrintDate,
	DocType,
	PrintJobType,
	ExpectedPageCount
FROM	PSPPrintJob
WHERE 	(@pkPSPPrintJob IS NULL OR pkPSPPrintJob = @pkPSPPrintJob)
 AND 	(@MachineName IS NULL OR MachineName LIKE @MachineName + '%')
 AND 	(@Username IS NULL OR Username LIKE @Username + '%')
 AND 	(@PrintDate IS NULL OR PrintDate = @PrintDate)
 AND 	(@DocType IS NULL OR DocType LIKE @DocType + '%')
 AND 	(@PrintJobType IS NULL OR PrintJobType = @PrintJobType)
 AND	(@ExpectedPageCount IS NULL OR ExpectedPageCount = @ExpectedPageCount)
 