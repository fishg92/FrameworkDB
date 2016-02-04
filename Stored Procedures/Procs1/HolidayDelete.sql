----------------------------------------------------------------------------
-- Delete a single record from Holiday
----------------------------------------------------------------------------
CREATE PROC [dbo].[HolidayDelete]
(	@HolidayDate datetime
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	Holiday
WHERE 	HolidayDate = @HolidayDate
