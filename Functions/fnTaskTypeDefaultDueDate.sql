
create   FUNCTION [dbo].[fnTaskTypeDefaultDueDate](
	@pkrefTaskType decimal
	,@StartDate datetime
	,@ConsiderHolidays bit
)

RETURNS datetime
AS
BEGIN

	declare @DueDate datetime
			,@DefaultDueMinutes decimal
			,@DueDateCalculationMethod varchar(10)
			
	select	@DefaultDueMinutes = DefaultDueMinutes
			,@DueDateCalculationMethod = DueDateCalculationMethod
	from	refTaskType
	where	pkrefTaskType = @pkrefTaskType

	set @DueDate = dateadd(minute,@DefaultDueMinutes,@StartDate)
		
	--Inspect each date in the period from the day after the start date
	--to the end date. If the date is a weekend or a holiday,
	--advance the due date by one day
	if @ConsiderHolidays = 1
	and @DueDateCalculationMethod = 'Business'
		begin
		declare @testDate datetime
		set @testDate = dbo.DatePortion(dateadd(day,1,@StartDate))

		while @testDate <= dbo.DatePortion(@DueDate)
			begin
			if datepart(dw,@testDate) in (1,7)
				set @DueDate = dateadd(day,1,@DueDate)
			else if exists (select * from Holiday
							where HolidayDate = @testDate)
				set @DueDate = dateadd(day,1,@DueDate)

			set @testDate = dateadd(day,1,@testDate)
			end
		end

	return @DueDate

END









