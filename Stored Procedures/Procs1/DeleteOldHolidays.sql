CREATE proc [dbo].[DeleteOldHolidays]
as
/*********************************
Holiday values should be deleted after 1 year
*********************************/
delete	Holiday
where	HolidayDate < dateadd(year,-1,getdate())