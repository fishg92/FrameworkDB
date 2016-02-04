CREATE PROCEDURE [dbo].[uspPSPGetApplicationUserFromRouteKeyword]
(
	  @RouteValue varchar(50)
	, @UserName varchar(50) OUTPUT
)
AS

	SELECT @UserName = UserName 
	FROM ApplicationUser
	WHERE WorkerNumber = @RouteValue