----------------------------------------------------------------------------
-- Update a single record in PSPJoinPrinterNameApplicationUser
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPJoinPrinterNameApplicationUserUpdate]
(	  @pkPSPJoinPrinterNameApplicationUser decimal(18, 0)
	, @fkPSPPrinterName decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPJoinPrinterNameApplicationUser
SET	fkPSPPrinterName = ISNULL(@fkPSPPrinterName, fkPSPPrinterName),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser)
WHERE 	pkPSPJoinPrinterNameApplicationUser = @pkPSPJoinPrinterNameApplicationUser
