----------------------------------------------------------------------------
-- Update a single record in JoinProfileSmartView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileSmartViewUpdate]
(	  @pkJoinProfileSmartView decimal(18, 0)
	, @fkProfile decimal(18, 0) = NULL
	, @fkSmartView decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinProfileSmartView
SET	fkProfile = ISNULL(@fkProfile, fkProfile),
	fkSmartView = ISNULL(@fkSmartView, fkSmartView)
WHERE 	pkJoinProfileSmartView = @pkJoinProfileSmartView
