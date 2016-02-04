-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from PSPPrintJobPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobPageDelete]
(	@pkPSPPrintJobPage decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	PSPPrintJobPage
WHERE 	pkPSPPrintJobPage = @pkPSPPrintJobPage
