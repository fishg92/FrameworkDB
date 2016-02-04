----------------------------------------------------------------------------
-- Insert a single record into PSPJoinPrinterNameApplicationUser
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPJoinPrinterNameApplicationUserInsert]
(	  @fkPSPPrinterName decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPJoinPrinterNameApplicationUser decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPJoinPrinterNameApplicationUser
(	  fkPSPPrinterName
	, fkApplicationUser
)
VALUES 
(	  @fkPSPPrinterName
	, @fkApplicationUser

)

SET @pkPSPJoinPrinterNameApplicationUser = SCOPE_IDENTITY()
