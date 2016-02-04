-- Stored Procedure

CREATE PROCEDURE [dbo].[uspPSPPrinterAssignmentAdd]
(
	  @fkApplicationUser decimal(18,0)
	, @fkPSPPrinterName decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	IF EXISTS(SELECT * FROM PSPJoinPrinterNameApplicationUser WHERE fkApplicationUser = @fkApplicationUser)
	BEGIN

		UPDATE PSPJoinPrinterNameApplicationUser SET fkPSPPrinterName = @fkPSPPrinterName
		WHERE fkApplicationUser = @fkApplicationUser

	END
	ELSE
	BEGIN

		INSERT INTO PSPJoinPrinterNameApplicationUser(fkPSPPrinterName,fkApplicationUser) 
		VALUES(@fkPSPPrinterName,@fkApplicationUser)

	END
