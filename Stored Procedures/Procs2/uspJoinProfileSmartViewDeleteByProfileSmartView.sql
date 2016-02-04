-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinProfileSmartView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileSmartViewDeleteByProfileSmartView]
(	@fkProfile decimal(18, 0)
	,@fkSmartView decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	JoinProfileSmartView
WHERE 	fkProfile = @fkProfile
		and fkSmartView = @fkSmartView
