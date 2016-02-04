-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in Report
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspReportUpdate]
(	  @pkReport decimal(18, 0)
	, @FriendlyName varchar(200) = NULL
	, @fkNCPApplication decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Report
SET	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	fkNCPApplication = ISNULL(@fkNCPApplication, fkNCPApplication)
WHERE 	pkReport = @pkReport
