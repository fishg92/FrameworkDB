
--[uspServiceDirectorySelect]
----------------------------------------------------------------------------
-- Select a single record from ServiceDirectory
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspServiceDirectorySelect]
(	@pkServiceDirectory decimal(18, 0) = NULL,
	@ServiceID varchar(100) = NULL,
	@ServiceName varchar(100) = NULL,
	@ImplementsIsAlive varchar(5) = NULL,
	@LUP datetime = NULL,
	@EndPointUri varchar(250) = NULL,
	@CurrentConnections int = NULL,
	@DiscoveryUrl varchar(250) = NULL

)
AS
--waitfor delay '00:10:00'
--RAISERROR ('just testing, j/k',10,1)

SELECT	pkServiceDirectory,
	ServiceID,
	ServiceName,
	ImplementsIsAlive,
	LUP,
	EndPointUri,
	CurrentConnections,
	DiscoveryUrl,
	ServiceUser,
	ServicePassword
FROM	ServiceDirectory
WHERE 	(@pkServiceDirectory IS NULL OR pkServiceDirectory = @pkServiceDirectory)
 AND 	(@ServiceID IS NULL OR ServiceID LIKE @ServiceID + '%')
 AND 	(@ServiceName IS NULL OR ServiceName LIKE @ServiceName + '%')
 AND 	(@ImplementsIsAlive IS NULL OR ImplementsIsAlive LIKE @ImplementsIsAlive + '%')
 AND 	(@LUP IS NULL OR LUP = @LUP)
 AND 	(@EndPointUri IS NULL OR EndPointUri LIKE @EndPointUri + '%')
 AND 	(@CurrentConnections IS NULL OR CurrentConnections = @CurrentConnections)
 AND	(@DiscoveryUrl IS NULL OR DiscoveryUrl = @DiscoveryUrl)
 and LUP > dateadd(s,-8000,getdate())
