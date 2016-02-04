----------------------------------------------------------------------------
-- Update a single record in SmartView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspSmartViewUpdate]
(	  @pkSmartView decimal(18, 0)
	, @Description varchar(100) = NULL
	, @IsDefault bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	SmartView
SET	Description = ISNULL(@Description, Description),
	IsDefault = ISNULL(@IsDefault, IsDefault)
WHERE 	pkSmartView = @pkSmartView
