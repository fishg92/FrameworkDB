----------------------------------------------------------------------------
-- Insert a single record into PSPPrintJobIndexValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPPrintJobIndexValueInsert]
(	  @fkPSPPrintJob decimal(18, 0)
	, @KeywordName varchar(255)
	, @KeywordValue varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPPrintJobIndexValue decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPPrintJobIndexValue
(	  fkPSPPrintJob
	, KeywordName
	, KeywordValue
)
VALUES 
(	  @fkPSPPrintJob
	, @KeywordName
	, @KeywordValue

)

SET @pkPSPPrintJobIndexValue = SCOPE_IDENTITY()
