----------------------------------------------------------------------------
-- Update a single record in CPJoinClientClientPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientClientPhoneUpdate]
(	  @pkCPJoinClientClientPhone decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkCPClientPhone decimal(18, 0) = NULL
	, @fkCPRefPhoneType decimal (18,0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPJoinClientClientPhone
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkCPClientPhone = ISNULL(@fkCPClientPhone, fkCPClientPhone),
	fkCPRefPhoneType = ISNULL(@fkCPRefPhoneType, fkCPRefPhoneType),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate)
WHERE 	pkCPJoinClientClientPhone = @pkCPJoinClientClientPhone
