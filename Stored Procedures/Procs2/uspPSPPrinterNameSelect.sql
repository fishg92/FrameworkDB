----------------------------------------------------------------------------
-- Select a single record from PSPPrinterName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrinterNameSelect]
(	@pkPSPPrinterName decimal(18, 0) = NULL,
	@PrinterName varchar(255) = NULL
)
AS

SELECT	pkPSPPrinterName,
	PrinterName
FROM	PSPPrinterName
WHERE 	(@pkPSPPrinterName IS NULL OR pkPSPPrinterName = @pkPSPPrinterName)
 AND 	(@PrinterName IS NULL OR PrinterName LIKE @PrinterName + '%')
 
