CREATE PROCEDURE [dbo].[SmartViewDelete] 
(	
	  @pkSmartView decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete from smartView 
where pkSmartView = @pkSmartView

delete from joinsmartviewdocumenttype
where fkSmartView = @pkSmartView
