----------------------------------------------------------------------------
-- Update a single record in refFileNetQueue
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefFileNetQueueUpdate]
(	  @pkrefFileNetQueue decimal(18, 0)
	, @QueueName varchar(50) = NULL
	, @PrimaryIndex varchar(50) = NULL
	, @FilterBy varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refFileNetQueue
SET	QueueName = ISNULL(@QueueName, QueueName),
	PrimaryIndex = ISNULL(@PrimaryIndex, PrimaryIndex),
	FilterBy = ISNULL(@FilterBy, FilterBy)
WHERE 	pkrefFileNetQueue = @pkrefFileNetQueue
