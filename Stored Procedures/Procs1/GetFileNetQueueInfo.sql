CREATE proc [dbo].[GetFileNetQueueInfo]
	@QueueName varchar(50)
	,@PrimaryIndex varchar(50) = null output
	,@FilterBy varchar(50) = null output
as

select	@PrimaryIndex = PrimaryIndex
		,@FilterBy = FilterBy
from	refFileNetQueue
where	QueueName = @QueueName

set @PrimaryIndex = isnull(@PrimaryIndex,'')
set @FilterBy = isnull(@FilterBy,'User')
