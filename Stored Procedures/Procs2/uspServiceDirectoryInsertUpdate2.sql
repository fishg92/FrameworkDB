





----------------------------------------------------------------------------
-- Insert or update a single record into ServiceDirectory
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspServiceDirectoryInsertUpdate2]
(	  @ServiceID varchar(100)
	, @ServiceName varchar(100)
	, @ImplementsIsAlive varchar(5)
	, @LUP datetime
	, @EndPointUri varchar(250)
	, @CurrentConnections int
	, @DiscoveryUrl varchar(250)
	, @StartDateTime datetime
	, @ServiceUser varchar(250)
	, @ServicePassword varchar(250)
	, @pkServiceDirectory decimal(18, 0) = NULL OUTPUT 
	, @ServiceMode varchar(100) = 'Private'
	, @ServiceProtocol varchar(50) = 'nettcp'
	, @ServiceType varchar(50) = 'WinSvc'
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
		, ServiceStartDateTime
		, ServiceUser
		, ServicePassword
		, ServiceMode
		, ServiceProtocol
		, ServiceType
	)
	VALUES 
	(	  @ServiceID
		, @ServiceName
		, @ImplementsIsAlive
		, @LUP
		, @EndPointUri
		, @CurrentConnections
		, @DiscoveryUrl
		, @StartDateTime
		, @ServiceUser
		, @ServicePassword
		, @ServiceMode
		, @ServiceProtocol
		, @ServiceType
	)

END ELSE BEGIN

	UPDATE	ServiceDirectory
		SET	ServiceID = ISNULL(@ServiceID, ServiceID),
			ImplementsIsAlive = ISNULL(@ImplementsIsAlive, ImplementsIsAlive),
			LUP = ISNULL(@LUP, LUP),
			EndPointUri = ISNULL(@EndPointUri, EndPointUri),
			CurrentConnections = ISNULL(@CurrentConnections, CurrentConnections),
			DiscoveryUrl = ISNULL(@DiscoveryUrl, DiscoveryUrl),
			ServiceUser = ISNULL(@ServiceUser, ServiceUser),
			ServicePassword = ISNULL(@ServicePassword, ServicePassword)
		 where ServiceName = @ServiceName

		if @StartDateTime <> '1/1/1900 12:00 AM' BEGIN
			UPDATE	ServiceDirectory
				SET	ServiceStartDateTime = @StartDateTime
				 where ServiceName = @ServiceName
		END

END



SET @pkServiceDirectory = SCOPE_IDENTITY()






