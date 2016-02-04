-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into PSPPrintJobPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobPageInsert]
(	  @fkPSPPrintJob decimal(18, 0)
	, @PageNumber int
	, @PageData varbinary(MAX)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPPrintJobPage decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

declare @Date datetime
set @Date = getdate()

INSERT PSPPrintJobPage
(	  fkPSPPrintJob
	, PageNumber
	, PageData
	, CreateUser
	, CreateDate
	, LUPUser
	, LUPDate
)
VALUES 
(	  @fkPSPPrintJob
	, @PageNumber
	, @PageData
	, @LUPUser
	, @Date
	, @LUPUser
	, @Date
)

SET @pkPSPPrintJobPage = SCOPE_IDENTITY()
