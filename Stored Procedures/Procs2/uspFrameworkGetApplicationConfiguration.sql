


CREATE proc [dbo].[uspFrameworkGetApplicationConfiguration]
(	@AppID int,
	@ItemKey varchar(200) = null
)
as

Select	ItemKey, ItemValue, ItemDescription, pkConfiguration
From	Configuration c with (NoLock) 
Where	c.AppID = @AppID
and		(@ItemKey is Null or c.ItemKey = @ItemKey)



