CREATE PROCEDURE [dbo].uspPSPGetUserFromQueueName
@PrintQueue varchar(255),
@UserName varchar(255) OUTPUT
AS

	SELECT @UserName = a.UserName
	FROM ApplicationUser a
	inner JOIN PSPJoinPrinterNameApplicationUser j 
	ON	j.fkApplicationUser = a.pkApplicationUser
	inner join PSPPrinterName p
	on j.fkPSPPrinterName = p.pkPSPPrinterName
	WHERE p.PrinterName = @PrintQueue