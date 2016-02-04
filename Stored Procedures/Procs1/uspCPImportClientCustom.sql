CREATE PROCEDURE [dbo].[uspCPImportClientCustom]
(
	  @fkCPClient decimal(18,0)
	, @DATA1 varchar(255)
	, @DATA2 varchar(255)
	, @DATA3 varchar(255)
	, @DATA4 varchar(255)
	, @DATA5 varchar(255)
	, @DATA6 varchar(255)
	, @DATA7 varchar(255)
	, @DATA8 varchar(255)
	, @DATA9 varchar(255)
	, @DATA10 varchar(255)
	, @DATA11 varchar(255)
	, @DATA12 varchar(255)
	, @DATA13 varchar(255)
	, @DATA14 varchar(255)
	, @DATA15 varchar(255)
	, @DATA16 varchar(255)
	, @DATA17 varchar(255)
	, @DATA18 varchar(255)
	, @DATA19 varchar(255)
	, @DATA20 varchar(255)
	, @DATA21 varchar(255)
	, @DATA22 varchar(255)
	, @DATA23 varchar(255)
	, @DATA24 varchar(255)
	, @DATA25 varchar(255)
	, @DATA26 varchar(255)
	, @DATA27 varchar(255)
	, @DATA28 varchar(255)
	, @DATA29 varchar(255)
	, @DATA30 varchar(255)
	, @DATA31 varchar(255)
	, @DATA32 varchar(255)
	, @DATA33 varchar(255)
	, @DATA34 varchar(255)
	, @DATA35 varchar(255)
	, @DATA36 varchar(255)
	, @DATA37 varchar(255)
	, @DATA38 varchar(255)
	, @DATA39 varchar(255)
	, @DATA40 varchar(255)
)
AS

SET NOCOUNT ON

DECLARE   @pkCPClientCustomAttribute decimal(18,0)
		, @EffectiveDate datetime
		, @HostName varchar(100)

SELECT @HostName = HOST_NAME()
SELECT @EffectiveDate = GETDATE()

SELECT @pkCPClientCustomAttribute = pkCPClientCustomAttribute
FROM CPClientCustomAttribute
WHERE fkCPClient = @fkCPClient

IF ISNULL(@pkCPClientCustomAttribute,0) = 0
BEGIN

	EXEC uspCPClientCustomAttributeInsert @fkCPClient = @fkCPClient
										, @DATA1  = @DATA1
										, @DATA2  = @DATA2
										, @DATA3  = @DATA3
										, @DATA4  = @DATA4
										, @DATA5  = @DATA5
										, @DATA6  = @DATA6
										, @DATA7  = @DATA7
										, @DATA8  = @DATA8
										, @DATA9  = @DATA9
										, @DATA10  = @DATA10
										, @DATA11  = @DATA11
										, @DATA12  = @DATA12
										, @DATA13  = @DATA13
										, @DATA14  = @DATA14
										, @DATA15  = @DATA15
										, @DATA16  = @DATA16
										, @DATA17  = @DATA17
										, @DATA18  = @DATA18
										, @DATA19  = @DATA19
										, @DATA20  = @DATA20
										, @DATA21  = @DATA21
										, @DATA22  = @DATA22
										, @DATA23  = @DATA23
										, @DATA24  = @DATA24
										, @DATA25  = @DATA25
										, @DATA26  = @DATA26
										, @DATA27  = @DATA27
										, @DATA28  = @DATA28
										, @DATA29  = @DATA29
										, @DATA30  = @DATA30
										, @DATA31  = @DATA31
										, @DATA32  = @DATA32
										, @DATA33  = @DATA33
										, @DATA34  = @DATA34
										, @DATA35  = @DATA35
										, @DATA36  = @DATA36
										, @DATA37  = @DATA37
										, @DATA38  = @DATA38
										, @DATA39  = @DATA39
										, @DATA40  = @DATA40
										, @LUPUser = @HostName
										, @LUPMac = @HostName
										, @LUPIP = @HostName
										, @LUPMachine = @HostName
END
ELSE
BEGIN

	EXEC uspCPClientCustomAttributeUpdate @pkCPClientCustomAttribute = @pkCPClientCustomAttribute
										, @fkCPClient = @fkCPClient
										, @DATA1  = @DATA1
										, @DATA2  = @DATA2
										, @DATA3  = @DATA3
										, @DATA4  = @DATA4
										, @DATA5  = @DATA5
										, @DATA6  = @DATA6
										, @DATA7  = @DATA7
										, @DATA8  = @DATA8
										, @DATA9  = @DATA9
										, @DATA10  = @DATA10
										, @DATA11  = @DATA11
										, @DATA12  = @DATA12
										, @DATA13  = @DATA13
										, @DATA14  = @DATA14
										, @DATA15  = @DATA15
										, @DATA16  = @DATA16
										, @DATA17  = @DATA17
										, @DATA18  = @DATA18
										, @DATA19  = @DATA19
										, @DATA20  = @DATA20
										, @DATA21  = @DATA21
										, @DATA22  = @DATA22
										, @DATA23  = @DATA23
										, @DATA24  = @DATA24
										, @DATA25  = @DATA25
										, @DATA26  = @DATA26
										, @DATA27  = @DATA27
										, @DATA28  = @DATA28
										, @DATA29  = @DATA29
										, @DATA30  = @DATA30
										, @DATA31  = @DATA31
										, @DATA32  = @DATA32
										, @DATA33  = @DATA33
										, @DATA34  = @DATA34
										, @DATA35  = @DATA35
										, @DATA36  = @DATA36
										, @DATA37  = @DATA37
										, @DATA38  = @DATA38
										, @DATA39  = @DATA39
										, @DATA40  = @DATA40
										, @LUPUser = @HostName
										, @LUPMac = @HostName
										, @LUPIP = @HostName
										, @LUPMachine = @HostName

END