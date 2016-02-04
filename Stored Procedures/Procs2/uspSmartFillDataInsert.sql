-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into SmartFillData
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSmartFillDataInsert]
(		@pkUser int
	, @clientCompassID varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	INSERT SmartFillData
		(	  fkApplicationUser
			, PeopleID
		)
		VALUES 
		(	  
			@pkUser
			, @clientCompassID
		)
