----------------------------------------------------------------------------
-- Insert a single record into CPClientCustomAttribute
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientCustomAttributeInsert]
(	  @fkCPClient decimal(18, 0)
	, @DATA1 varchar(250)
	, @DATA2 varchar(250)
	, @DATA3 varchar(250)
	, @DATA4 varchar(250)
	, @DATA5 varchar(250)
	, @DATA6 varchar(250)
	, @DATA7 varchar(250)
	, @DATA8 varchar(250)
	, @DATA9 varchar(250)
	, @DATA10 varchar(250)
	, @DATA11 varchar(250)
	, @DATA12 varchar(250)
	, @DATA13 varchar(250)
	, @DATA14 varchar(250)
	, @DATA15 varchar(250)
	, @DATA16 varchar(250)
	, @DATA17 varchar(250)
	, @DATA18 varchar(250)
	, @DATA19 varchar(250)
	, @DATA20 varchar(250)
	, @DATA21 varchar(250)
	, @DATA22 varchar(250)
	, @DATA23 varchar(250)
	, @DATA24 varchar(250)
	, @DATA25 varchar(250)
	, @DATA26 varchar(250)
	, @DATA27 varchar(250)
	, @DATA28 varchar(250)
	, @DATA29 varchar(250)
	, @DATA30 varchar(250)
	, @DATA31 varchar(250)
	, @DATA32 varchar(250)
	, @DATA33 varchar(250)
	, @DATA34 varchar(250)
	, @DATA35 varchar(250)
	, @DATA36 varchar(250)
	, @DATA37 varchar(250)
	, @DATA38 varchar(250)
	, @DATA39 varchar(250)
	, @DATA40 varchar(250)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPClientCustomAttribute decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPClientCustomAttribute
(	  fkCPClient
	, DATA1
	, DATA2
	, DATA3
	, DATA4
	, DATA5
	, DATA6
	, DATA7
	, DATA8
	, DATA9
	, DATA10
	, DATA11
	, DATA12
	, DATA13
	, DATA14
	, DATA15
	, DATA16
	, DATA17
	, DATA18
	, DATA19
	, DATA20
	, DATA21
	, DATA22
	, DATA23
	, DATA24
	, DATA25
	, DATA26
	, DATA27
	, DATA28
	, DATA29
	, DATA30
	, DATA31
	, DATA32
	, DATA33
	, DATA34
	, DATA35
	, DATA36
	, DATA37
	, DATA38
	, DATA39
	, DATA40
)
VALUES 
(	  @fkCPClient
	, @DATA1
	, @DATA2
	, @DATA3
	, @DATA4
	, @DATA5
	, @DATA6
	, @DATA7
	, @DATA8
	, @DATA9
	, @DATA10
	, @DATA11
	, @DATA12
	, @DATA13
	, @DATA14
	, @DATA15
	, @DATA16
	, @DATA17
	, @DATA18
	, @DATA19
	, @DATA20
	, @DATA21
	, @DATA22
	, @DATA23
	, @DATA24
	, @DATA25
	, @DATA26
	, @DATA27
	, @DATA28
	, @DATA29
	, @DATA30
	, @DATA31
	, @DATA32
	, @DATA33
	, @DATA34
	, @DATA35
	, @DATA36
	, @DATA37
	, @DATA38
	, @DATA39
	, @DATA40

)

SET @pkCPClientCustomAttribute = SCOPE_IDENTITY()
