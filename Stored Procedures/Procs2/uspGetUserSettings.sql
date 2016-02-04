




-- [uspGetUserSettings] 2

CREATE      procedure [dbo].[uspGetUserSettings]
(	@pkApplicationUser decimal
)
as

 select 
pkUserSettings
,fkApplicationUser
,[Grouping]
,ItemKey
,ItemValue
,ItemDescription
,AppID
,Sequence
,LUPDate
From UserSettings with (NOLOCK) where fkApplicationUser = @pkApplicationUser





