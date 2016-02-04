

CREATE proc [dbo].[uspFrameworkGetApplicationUserConfiguration]
(	@pkApplicationUser decimal(18,0),
	@AppID int,
	@ItemKey varchar(200) = null
)
as

Select	ItemKey, ItemValue, ItemDescription, pkConfiguration
From	Configuration c with (NoLock) 
Join	JoinApplicationUserConfiguration j with (NoLock) on j.fkConfiguration = c.pkConfiguration
Where	j.fkApplicationUser = @pkApplicationUser
and		c.AppID = @AppID
and		(@ItemKey is Null or c.ItemKey = @ItemKey)


