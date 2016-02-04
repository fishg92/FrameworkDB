----------------------------------------------------------------------------
-- Select a single record from CPJoinClientClientAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientClientAddressSelect]
(	@pkCPJoinClientClientAddress decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkCPClientAddress decimal(18, 0) = NULL,
	@fkCPRefClientAddressType decimal(18, 0) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPJoinClientClientAddress,
	fkCPClient,
	fkCPClientAddress,
	fkCPRefClientAddressType,
	LockedUser,
	LockedDate
FROM	CPJoinClientClientAddress
WHERE 	(@pkCPJoinClientClientAddress IS NULL OR pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkCPClientAddress IS NULL OR fkCPClientAddress = @fkCPClientAddress)
 AND 	(@fkCPRefClientAddressType IS NULL OR fkCPRefClientAddressType = @fkCPRefClientAddressType)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)

