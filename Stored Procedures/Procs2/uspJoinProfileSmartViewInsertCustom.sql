----------------------------------------------------------------------------
-- Insert a single record into JoinProfileSmartView if join doesn't already exist for that doc type and smart view
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileSmartViewInsertCustom]
(	  @fkProfile decimal(18, 0)
	, @fkSmartView decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinProfileSmartView decimal(18, 0) = NULL OUTPUT 
)
AS

IF not exists (select * from JoinProfileSmartview where fkSmartView = @fkSmartView	
						and fkProfile = @fkProfile
				)
		begin

			exec dbo.uspJoinProfileSmartViewInsert
				 @fkProfile
	, @fkSmartView 
	, @LUPUser
	, @LUPMac
	, @LUPIP
	, @LUPMachine
	, @pkJoinProfileSmartView
		end
	

SET @pkJoinProfileSmartView = SCOPE_IDENTITY()
