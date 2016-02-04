
CREATE proc [dbo].[DefaultAutoFillSource]
as
declare @source int

declare @ItemKey varchar(100)


SET @ItemKey = 'ProfileAutoFillSchemaDataViewSource'



select	@source = ItemValue
from	dbo.ProfileSetting
where	ItemKey = rtrim(@ItemKey)
and		fkProfile = -1
and		AppID = 10
and		isnumeric(ItemValue) = 1

select DefaultAutoFillSource = isnull(@source,1)
