----------------------------------------------------------------------------
-- Select a single record from PSPJoinPrinterNameApplicationUser
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPJoinPrinterNameApplicationUserSelect]
(	@pkPSPJoinPrinterNameApplicationUser decimal(18, 0) = NULL,
	@fkPSPPrinterName decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL
)
AS

SELECT	pkPSPJoinPrinterNameApplicationUser,
	fkPSPPrinterName,
	fkApplicationUser
FROM	PSPJoinPrinterNameApplicationUser
WHERE 	(@pkPSPJoinPrinterNameApplicationUser IS NULL OR pkPSPJoinPrinterNameApplicationUser = @pkPSPJoinPrinterNameApplicationUser)
 AND 	(@fkPSPPrinterName IS NULL OR fkPSPPrinterName = @fkPSPPrinterName)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 