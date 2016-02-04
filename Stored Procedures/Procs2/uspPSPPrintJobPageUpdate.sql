-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in PSPPrintJobPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobPageUpdate]
(	  @pkPSPPrintJobPage decimal(18, 0)
	, @fkPSPPrintJob decimal(18, 0) = NULL
	, @PageNumber int = NULL
	, @PageData varbinary(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

declare @Date datetime
set @Date = getdate()

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPPrintJobPage
SET	fkPSPPrintJob = ISNULL(@fkPSPPrintJob, fkPSPPrintJob)
	,PageNumber = ISNULL(@PageNumber, PageNumber)
	,PageData = ISNULL(@PageData, PageData)
	,LUPUser = @LUPUser
	,LUPDate = @Date
WHERE 	pkPSPPrintJobPage = @pkPSPPrintJobPage
