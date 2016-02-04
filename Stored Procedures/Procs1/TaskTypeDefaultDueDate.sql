CREATE proc [dbo].[TaskTypeDefaultDueDate]
	@pkrefTaskType decimal
	,@StartDate datetime
	,@ConsiderHolidays bit = 1
as

declare @DueDate datetime

select @DueDate = dbo.fnTaskTypeDefaultDueDate(@pkrefTaskType, @StartDate, @ConsiderHolidays)
		
select DueDate = @DueDate