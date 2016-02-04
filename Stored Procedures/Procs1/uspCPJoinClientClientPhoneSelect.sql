
----------------------------------------------------------------------------
-- Select a single record from CPJoinClientClientPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientClientPhoneSelect]
(	@pkCPJoinClientClientPhone decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkCPClientPhone decimal(18, 0) = NULL,
	@fkCPRefPhoneType decimal(18, 0) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPJoinClientClientPhone,
	fkCPClient,
	fkCPClientPhone,
	LockedUser,
	LockedDate
FROM	CPJoinClientClientPhone
WHERE 	(@pkCPJoinClientClientPhone IS NULL OR pkCPJoinClientClientPhone = @pkCPJoinClientClientPhone)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkCPClientPhone IS NULL OR fkCPClientPhone = @fkCPClientPhone)
 AND 	(@fkCPRefPhoneType IS NULL OR fkCPRefPhoneType = @fkCPRefPhoneType)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)


