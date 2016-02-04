CREATE PROCEDURE [dbo].[uspPSPGetPrinterForUser]
(
	  @UserName varchar(255)
	, @PrinterName varchar(255) OUTPUT
)
AS

	SELECT @PrinterName = p.PrinterName
	FROM PSPPrinterName p
	JOIN PSPJoinPrinterNameApplicationUser j ON j.fkPSPPrinterName = p.pkPSPPrinterName
	JOIN ApplicationUser a ON j.fkApplicationUser = a.pkApplicationUser
	WHERE 
	a.WorkerNumber = @UserName