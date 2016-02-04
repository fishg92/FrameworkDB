create proc [dbo].[GetDefaultSmartView]
as

select	pkSmartView
from	SmartView
where	IsDefault = 1
