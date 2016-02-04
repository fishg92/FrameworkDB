----------------------------------------------------------------------------
-- Insert a single record into Holiday
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspHolidayInsert]
(	  @HolidayDate datetime
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkHoliday decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Holiday
(	  HolidayDate
)
VALUES 
(	  @HolidayDate

)

SET @pkHoliday = SCOPE_IDENTITY()
