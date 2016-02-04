create proc dbo.DefaultCaseManagerAutoFillField
as

declare @field varchar(255)

select	@field = ItemValue
from	dbo.ProfileSetting
where	ItemKey = 'CaseManagerAutoFillField'
and		fkProfile = -1
and		AppID = 10

select CaseManagerAutoFillField = isnull(@field,'')
