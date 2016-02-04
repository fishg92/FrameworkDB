----------------------------------------------------------------------------
-- Update a single record in CPClientPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientPhoneUpdate]
(	  @pkCPClientPhone decimal(18, 0)
	, @fkCPRefPhoneType decimal(18, 0) = NULL
	, @Number varchar(10) = NULL
	, @Extension varchar(10) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientPhone
SET	fkCPRefPhoneType = ISNULL(@fkCPRefPhoneType, fkCPRefPhoneType),
	Number = ISNULL(@Number, Number),
	Extension = ISNULL(@Extension, Extension),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate)
WHERE 	pkCPClientPhone = @pkCPClientPhone
