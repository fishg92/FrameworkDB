----------------------------------------------------------------------------
-- Insert a single record into JoinProfileSmartView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinProfileSmartViewInsert]
(	  @fkProfile decimal(18, 0)
	, @fkSmartView decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinProfileSmartView decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinProfileSmartView
(	  fkProfile
	, fkSmartView
)
VALUES 
(	  @fkProfile
	, @fkSmartView

)

SET @pkJoinProfileSmartView = SCOPE_IDENTITY()
