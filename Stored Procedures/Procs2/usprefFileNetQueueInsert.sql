----------------------------------------------------------------------------
-- Insert a single record into refFileNetQueue
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefFileNetQueueInsert]
(	  @QueueName varchar(50)
	, @PrimaryIndex varchar(50)
	, @FilterBy varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefFileNetQueue decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refFileNetQueue
(	  QueueName
	, PrimaryIndex
	, FilterBy
)
VALUES 
(	  @QueueName
	, @PrimaryIndex
	, COALESCE(@FilterBy, 'User')

)

SET @pkrefFileNetQueue = SCOPE_IDENTITY()
