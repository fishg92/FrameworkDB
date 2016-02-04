



----------------------------------------------------------------------------
-- Insert or update a single record into ServiceDirectory
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspServiceDirectoryInsertUpdate]
(	  @ServiceID varchar(100)
	, @ServiceName varchar(100)
	, @ImplementsIsAlive varchar(5)
	, @LUP datetime
	, @EndPointUri varchar(250)
	, @CurrentConnections int
	, @DiscoveryUrl varchar(250)
	, @pkServiceDirectory decimal(18, 0) = NULL OUTPUT 
)
AS
if not exists 
	(select * from ServiceDirectory with (NOLOCK) where ServiceName = @ServiceName)
BEGIN

	INSERT ServiceDirectory
	(	  ServiceID
		, ServiceName
		, ImplementsIsAlive
		, LUP
		, EndPointUri
		, CurrentConnections
		, DiscoveryUrl
	)
	VALUES 
	(	  @ServiceID
		, @ServiceName
		, @ImplementsIsAlive
		, @LUP
		, @EndPointUri
		, @CurrentConnections
		, @DiscoveryUrl

	)

END ELSE BEGIN

	UPDATE	ServiceDirectory
		SET	ServiceID = ISNULL(@ServiceID, ServiceID),
			ImplementsIsAlive = ISNULL(@ImplementsIsAlive, ImplementsIsAlive),
			LUP = ISNULL(@LUP, LUP),
			EndPointUri = ISNULL(@EndPointUri, EndPointUri),
			CurrentConnections = ISNULL(@CurrentConnections, CurrentConnections),
			DiscoveryUrl = ISNULL(@DiscoveryUrl, DiscoveryUrl)
		 where ServiceName = @ServiceName

END



SET @pkServiceDirectory = SCOPE_IDENTITY()




