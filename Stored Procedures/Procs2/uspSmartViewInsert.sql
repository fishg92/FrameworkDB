----------------------------------------------------------------------------
-- Insert a single record into SmartView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSmartViewInsert]
(	  @Description varchar(100)
	, @IsDefault bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkSmartView decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT SmartView
(	  Description
	, IsDefault
)
VALUES 
(	  @Description
	, @IsDefault

)

SET @pkSmartView = SCOPE_IDENTITY()
