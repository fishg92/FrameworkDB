-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPClientPhone
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientPhoneInsert]
(	  @fkCPRefPhoneType decimal(18, 0) = NULL
	, @Number varchar(10) = NULL
	, @Extension varchar(10) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPClientPhone decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

SET NOCOUNT ON
DECLARE @pkToCheckFor decimal
SET @pkToCheckFor = 0

SELECT @pkToCheckFor = pkCPClientPhone 
FROM [CPClientPhone] (NOLOCK)
WHERE UPPER(LTRIM(RTRIM(ISNULL([Number], '')))) = UPPER(LTRIM(RTRIM(@Number)))
AND UPPER(LTRIM(RTRIM(ISNULL([Extension], '')))) = UPPER(LTRIM(RTRIM(@Extension)))
AND [fkCPRefPhoneType] = @fkCPRefPhoneType

IF ISNULL(@pkToCheckFor, 0) = 0
BEGIN
	INSERT CPClientPhone
	(	  fkCPRefPhoneType
		, Number
		, Extension
		, LockedUser
		, LockedDate
	)
	VALUES 
	(	  @fkCPRefPhoneType
		, @Number
		, @Extension
		, @LockedUser
		, @LockedDate
	)

	SET @pkCPClientPhone = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SET @pkCPClientPhone = @pkToCheckFor
END
