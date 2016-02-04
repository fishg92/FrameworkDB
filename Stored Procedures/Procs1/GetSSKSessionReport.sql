
CREATE proc [dbo].[GetSSKSessionReport]

as

set nocount on

Select SessionID = al.Data10,
	   SessionDate = dbo.DatePortion(al.DateData5),
	   MachineName = al.MachineName,
	   ReportMonthName = (Select DateName(Month, Min(DateData5))
				          From ActivityLog (NoLock)
				          Where Data10 = al.Data10),
	   ReportMonth = (Select DatePart(Month, Min(DateData5))
				      From ActivityLog (NoLock)
				      Where Data10 = al.Data10),
	   ReportDay = (Select DateName(Day, Min(DateData5))
				    From ActivityLog (NoLock)
				    Where Data10 = al.Data10),
	   ReportDayName = (Select DateName(WeekDay, Min(DateData5))
				        From ActivityLog (NoLock)
				        Where Data10 = al.Data10), 
	   ReportHour = (Select DateName(Hour, Min(DateData5))
				     From ActivityLog (NoLock)
				     Where Data10 = al.Data10),
	   Duration = (Select DateDiff(s, Min(DateData5), Max(DateData5))
				   From ActivityLog (NoLock)
				   Where Data10 = al.Data10),
	   PagesScanned = (Select count(DecimalData1)
								   From ActivityLog (NoLock)
								   Where Data10 = al.Data10
								   And fkrefActivityType = 31),
	  /* PagesScanned = Convert(Int, Case When (Select DecimalData1
								   From ActivityLog (NoLock)
								   Where Data10 = al.Data10
								   And fkrefActivityType = 31) is null 
					  Then 0 Else (Select DecimalData1
								   From ActivityLog (NoLock)
								   Where Data10 = al.Data10
								   And fkrefActivityType = 31) End), */
	   Abandoned = Case When (Select Count(*) 
							  From ActivityLog (NoLock)
							  Where Data10 = al.Data10
							  And fkrefActivityType = 36) > 0 
				   Then 0 Else 1 End
From ActivityLog al (NoLock)
Where IsNull(al.Data10, '00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000'
And al.DateData5 is not null
Group By al.Data10, dbo.DatePortion(al.DateData5), al.MachineName
Order By dbo.DatePortion(al.DateData5)

