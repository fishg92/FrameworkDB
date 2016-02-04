----------------------------------------------------------------------------
-- Update a single record in CPClientCustomAttribute
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientCustomAttributeUpdate]
(	  @pkCPClientCustomAttribute decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @DATA1 varchar(250) = NULL
	, @DATA2 varchar(250) = NULL
	, @DATA3 varchar(250) = NULL
	, @DATA4 varchar(250) = NULL
	, @DATA5 varchar(250) = NULL
	, @DATA6 varchar(250) = NULL
	, @DATA7 varchar(250) = NULL
	, @DATA8 varchar(250) = NULL
	, @DATA9 varchar(250) = NULL
	, @DATA10 varchar(250) = NULL
	, @DATA11 varchar(250) = NULL
	, @DATA12 varchar(250) = NULL
	, @DATA13 varchar(250) = NULL
	, @DATA14 varchar(250) = NULL
	, @DATA15 varchar(250) = NULL
	, @DATA16 varchar(250) = NULL
	, @DATA17 varchar(250) = NULL
	, @DATA18 varchar(250) = NULL
	, @DATA19 varchar(250) = NULL
	, @DATA20 varchar(250) = NULL
	, @DATA21 varchar(250) = NULL
	, @DATA22 varchar(250) = NULL
	, @DATA23 varchar(250) = NULL
	, @DATA24 varchar(250) = NULL
	, @DATA25 varchar(250) = NULL
	, @DATA26 varchar(250) = NULL
	, @DATA27 varchar(250) = NULL
	, @DATA28 varchar(250) = NULL
	, @DATA29 varchar(250) = NULL
	, @DATA30 varchar(250) = NULL
	, @DATA31 varchar(250) = NULL
	, @DATA32 varchar(250) = NULL
	, @DATA33 varchar(250) = NULL
	, @DATA34 varchar(250) = NULL
	, @DATA35 varchar(250) = NULL
	, @DATA36 varchar(250) = NULL
	, @DATA37 varchar(250) = NULL
	, @DATA38 varchar(250) = NULL
	, @DATA39 varchar(250) = NULL
	, @DATA40 varchar(250) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientCustomAttribute
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	DATA1 = ISNULL(@DATA1, DATA1),
	DATA2 = ISNULL(@DATA2, DATA2),
	DATA3 = ISNULL(@DATA3, DATA3),
	DATA4 = ISNULL(@DATA4, DATA4),
	DATA5 = ISNULL(@DATA5, DATA5),
	DATA6 = ISNULL(@DATA6, DATA6),
	DATA7 = ISNULL(@DATA7, DATA7),
	DATA8 = ISNULL(@DATA8, DATA8),
	DATA9 = ISNULL(@DATA9, DATA9),
	DATA10 = ISNULL(@DATA10, DATA10),
	DATA11 = ISNULL(@DATA11, DATA11),
	DATA12 = ISNULL(@DATA12, DATA12),
	DATA13 = ISNULL(@DATA13, DATA13),
	DATA14 = ISNULL(@DATA14, DATA14),
	DATA15 = ISNULL(@DATA15, DATA15),
	DATA16 = ISNULL(@DATA16, DATA16),
	DATA17 = ISNULL(@DATA17, DATA17),
	DATA18 = ISNULL(@DATA18, DATA18),
	DATA19 = ISNULL(@DATA19, DATA19),
	DATA20 = ISNULL(@DATA20, DATA20),
	DATA21 = ISNULL(@DATA21, DATA21),
	DATA22 = ISNULL(@DATA22, DATA22),
	DATA23 = ISNULL(@DATA23, DATA23),
	DATA24 = ISNULL(@DATA24, DATA24),
	DATA25 = ISNULL(@DATA25, DATA25),
	DATA26 = ISNULL(@DATA26, DATA26),
	DATA27 = ISNULL(@DATA27, DATA27),
	DATA28 = ISNULL(@DATA28, DATA28),
	DATA29 = ISNULL(@DATA29, DATA29),
	DATA30 = ISNULL(@DATA30, DATA30),
	DATA31 = ISNULL(@DATA31, DATA31),
	DATA32 = ISNULL(@DATA32, DATA32),
	DATA33 = ISNULL(@DATA33, DATA33),
	DATA34 = ISNULL(@DATA34, DATA34),
	DATA35 = ISNULL(@DATA35, DATA35),
	DATA36 = ISNULL(@DATA36, DATA36),
	DATA37 = ISNULL(@DATA37, DATA37),
	DATA38 = ISNULL(@DATA38, DATA38),
	DATA39 = ISNULL(@DATA39, DATA39),
	DATA40 = ISNULL(@DATA40, DATA40)
WHERE 	pkCPClientCustomAttribute = @pkCPClientCustomAttribute
