----------------------------------------------------------------------------
-- Select a single record from refFileNetQueue
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefFileNetQueueSelect]
(	@pkrefFileNetQueue decimal(18, 0) = NULL,
	@QueueName varchar(50) = NULL,
	@PrimaryIndex varchar(50) = NULL,
	@FilterBy varchar(50) = NULL
)
AS

SELECT	pkrefFileNetQueue,
	QueueName,
	PrimaryIndex,
	FilterBy
FROM	refFileNetQueue
WHERE 	(@pkrefFileNetQueue IS NULL OR pkrefFileNetQueue = @pkrefFileNetQueue)
 AND 	(@QueueName IS NULL OR QueueName LIKE @QueueName + '%')
 AND 	(@PrimaryIndex IS NULL OR PrimaryIndex LIKE @PrimaryIndex + '%')
 AND 	(@FilterBy IS NULL OR FilterBy LIKE @FilterBy + '%')
