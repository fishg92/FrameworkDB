CREATE PROCEDURE [dbo].[uspCPImportClientPhone]
(
	  @pkCPClient decimal(18,0)
	, @PhoneNumber varchar(10)
	, @fkCPRefPhoneType decimal(18,0)
)
AS

SET NOCOUNT ON

DECLARE   @pkCPClientPhone decimal(18,0)
		, @EffectiveDate datetime
		, @HostName varchar(100)

SELECT @HostName = HOST_NAME()
SELECT @EffectiveDate = GETDATE()

IF ISNULL(@PhoneNumber, '') <> ''
BEGIN
	EXEC uspCPClientPhoneInsert   @fkCPRefPhoneType = @fkCPRefPhoneType
								, @Number = @PhoneNumber
								, @Extension = ''
								, @LUPUser = @HostName
								, @LUPMac = @HostName
								, @LUPIP = @HostName
								, @LUPMachine = @HostName
								, @pkCPClientPhone = @pkCPClientPhone output
								
	IF ISNULL(@pkCPClientPhone,0) <> 0
	BEGIN
		EXEC uspCPJoinClientClientPhoneInsert @fkCPClient = @pkCPClient
											, @fkCPClientPhone = @pkCPClientPhone
											, @fkCPRefPhoneType = @fkCPRefPhoneType
											, @LUPUser = @HostName
											, @LUPMac = @HostName
											, @LUPIP = @HostName
											, @LUPMachine = @HostName
	END
END