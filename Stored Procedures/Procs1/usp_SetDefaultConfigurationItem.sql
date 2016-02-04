CREATE proc [dbo].[usp_SetDefaultConfigurationItem]
	@ItemKey varchar(200)
	,@ItemValue varchar(300)
	,@ItemDescription varchar(300) = ''
	,@AppID int = -1
as

if not exists (select * from Configuration where ItemKey = @ItemKey)
	insert	Configuration
		(
			Grouping
			,ItemKey
			,ItemValue
			,ItemDescription
			,AppID
			,Sequence
		) values (
			''
			,@ItemKey
			,@ItemValue
			,@ItemDescription
			,@AppID
			,0
		)