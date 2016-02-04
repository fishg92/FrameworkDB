----------------------------------------------------------------------------
-- Select a single record from Holiday
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspHolidaySelect]
(	@pkHoliday decimal(18, 0) = NULL,
	@HolidayDate datetime = NULL
)
AS

SELECT	pkHoliday,
	HolidayDate
FROM	Holiday
WHERE 	(@pkHoliday IS NULL OR pkHoliday = @pkHoliday)
 AND 	(@HolidayDate IS NULL OR HolidayDate = @HolidayDate)
