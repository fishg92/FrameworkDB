----------------------------------------------------------------------------
-- Update a single record in PSPPrinterName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrinterNameUpdate]
(	  @pkPSPPrinterName decimal(18, 0)
	, @PrinterName varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPPrinterName
SET	PrinterName = ISNULL(@PrinterName, PrinterName)
WHERE 	pkPSPPrinterName = @pkPSPPrinterName
