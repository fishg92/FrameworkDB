-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in Holiday
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspHolidayUpdate]
(	  @pkHoliday decimal(18, 0)
	, @HolidayDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Holiday
SET	HolidayDate = ISNULL(@HolidayDate, HolidayDate)
WHERE 	pkHoliday = @pkHoliday
