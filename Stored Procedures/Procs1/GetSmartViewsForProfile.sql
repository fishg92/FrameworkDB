CREATE proc [dbo].[GetSmartViewsForProfile]
	@fkProfile decimal
as

select	SmartView.pkSmartView
		,SmartView.Description
		,SmartView.IsDefault
from	SmartView
join	JoinProfileSmartView
	on SmartView.pkSmartView = JoinProfileSmartView.fkSmartView
where	JoinProfileSmartView.fkProfile = @fkProfile

union

select	SmartView.pkSmartView
		,SmartView.Description
		,SmartView.IsDefault
from	SmartView
where	IsDefault = 1
