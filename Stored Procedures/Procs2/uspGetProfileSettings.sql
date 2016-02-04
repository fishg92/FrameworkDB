





-- [uspGetProfileSettings] 1, 2

CREATE procedure [dbo].[uspGetProfileSettings]
(	@AppID int
	,@fkProfile decimal
)
as

 select 
	[pkProfileSetting] 
	,[Grouping]
	,[ItemKey] 
	,[ItemValue]
	,[AppID] 
	,[fkProfile]
From ProfileSetting where AppID = @AppID and fkProfile = @fkProfile 





