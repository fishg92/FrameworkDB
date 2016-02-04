----------------------------------------------------------------------------
-- Insert a single record into PSPPrinterName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPPrinterNameInsert]
(	  @PrinterName varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPPrinterName decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPPrinterName
(	  PrinterName
)
VALUES 
(	  @PrinterName

)

SET @pkPSPPrinterName = SCOPE_IDENTITY()
