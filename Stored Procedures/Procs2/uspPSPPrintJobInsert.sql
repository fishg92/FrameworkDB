-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into PSPPrintJob
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobInsert]
(	  @MachineName varchar(255) = NULL
	, @Username varchar(255) = NULL
	, @PrintDate datetime = NULL
	, @DocType varchar(50) = NULL
	, @PrintJobType int = NULL
	, @fkPSPDocType decimal(18,0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPPrintJob decimal(18, 0) = NULL OUTPUT 
	, @ExpectedPageCount int = NULL
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

declare @Date datetime
set @Date = getdate()

INSERT PSPPrintJob
(	  MachineName
	, Username
	, PrintDate
	, DocType
	, PrintJobType
	, fkPSPDocType
	, CreateUser
	, CreateDate
	, LUPUser
	, LUPDate
	, ExpectedPageCount
)
VALUES 
(	  @MachineName
	, @Username
	, @PrintDate
	, @DocType
	, @PrintJobType
	, @fkPSPDocType
	, @LUPUser
	, @Date
	, @LUPUser
	, @Date
	, @ExpectedPageCount
)

SET @pkPSPPrintJob = SCOPE_IDENTITY()
