----------------------------------------------------------------------------
-- Update a single record in PSPPrintJob
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobUpdate]
(	  @pkPSPPrintJob decimal(18, 0)
	, @MachineName varchar(255) = NULL
	, @Username varchar(255) = NULL
	, @PrintDate datetime = NULL
	, @DocType varchar(50) = NULL
	, @PrintJobType int = NULL
	, @ExpectedPageCount int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine
	
declare @Date datetime
set @Date = getdate()

UPDATE	PSPPrintJob
SET	MachineName = ISNULL(@MachineName, MachineName)
	,Username = ISNULL(@Username, Username)
	,PrintDate = ISNULL(@PrintDate, PrintDate)
	,DocType = ISNULL(@DocType, DocType)
	,PrintJobType = ISNULL(@PrintJobType, PrintJobType)
	,ExpectedPageCount = ISNULL(@ExpectedPageCount, ExpectedPageCount)
	,LUPUser = @LUPUser
	,LUPDate = @Date
WHERE 	pkPSPPrintJob = @pkPSPPrintJob
