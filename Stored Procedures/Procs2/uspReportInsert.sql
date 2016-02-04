-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into Report
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspReportInsert]
(	  @FriendlyName varchar(200)
	, @fkNCPApplication decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkReport decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Report
(	  pkReport
	, FriendlyName
	, fkNCPApplication
)
VALUES 
(	  @pkReport
	, @FriendlyName
	, @fkNCPApplication

)

SET @pkReport = SCOPE_IDENTITY()
