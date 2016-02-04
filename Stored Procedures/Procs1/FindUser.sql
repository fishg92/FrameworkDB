CREATE PROCEDURE [api].[FindUser]
	 @UserName AS VARCHAR(50) = NULL
	,@UserID AS NVARCHAR(150) = NULL
AS

SELECT *
FROM ApplicationUser a
WHERE ( UserName = @UserName 
		OR 
		ExternalIDNumber = @UserID)
AND IsActive = 1 AND EXISTS(SELECT * 
							FROM JoinApplicationUserRefRole r 
							INNER JOIN JoinrefRolerefPermission p ON r.fkrefRole = p.fkrefRole
							WHERE r.fkApplicationUser = a.pkApplicationUser 
							AND p.fkrefPermission = 18)