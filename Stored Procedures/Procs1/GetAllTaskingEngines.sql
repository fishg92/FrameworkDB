CREATE proc [dbo].[GetAllTaskingEngines]
	@ActiveOnly bit = 0
/*****************
getalltaskingengines 1
*****************/
as

declare @ConfigTaskingEngine varchar(100)

select	@ConfigTaskingEngine = ItemValue
from	Configuration
where	ItemKey = 'ExternalTaskingEngine'

select distinct
	TaskingEngine = 
	case
		when DMSTaskTypeID = ''
			then 'Compass'
		else
			@ConfigTaskingEngine
	end
from refTaskType
where Active = 1
or @ActiveOnly = 0