----------------------------------------------------------------------------
-- Update a single record in JoinProfileAutoFillSchemaDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileAutoFillSchemaDataViewUpdate]
(	  @pkJoinProfileAutoFillSchemaDataView decimal(18, 0)
	, @fkProfile decimal(18, 0) = NULL
	, @fkAutoFillSchemaDataView decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinProfileAutoFillSchemaDataView
SET	fkProfile = ISNULL(@fkProfile, fkProfile),
	fkAutoFillSchemaDataView = ISNULL(@fkAutoFillSchemaDataView, fkAutoFillSchemaDataView)
WHERE 	pkJoinProfileAutoFillSchemaDataView = @pkJoinProfileAutoFillSchemaDataView
