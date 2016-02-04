----------------------------------------------------------------------------
-- Update a single record in PSPPrintJobIndexValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobIndexValueUpdate]
(	  @pkPSPPrintJobIndexValue decimal(18, 0)
	, @fkPSPPrintJob decimal(18, 0) = NULL
	, @KeywordName varchar(255) = NULL
	, @KeywordValue varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPPrintJobIndexValue
SET	fkPSPPrintJob = ISNULL(@fkPSPPrintJob, fkPSPPrintJob),
	KeywordName = ISNULL(@KeywordName, KeywordName),
	KeywordValue = ISNULL(@KeywordValue, KeywordValue)
WHERE 	pkPSPPrintJobIndexValue = @pkPSPPrintJobIndexValue
