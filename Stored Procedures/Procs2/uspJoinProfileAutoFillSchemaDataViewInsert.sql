----------------------------------------------------------------------------
-- Insert a single record into JoinProfileAutoFillSchemaDataView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinProfileAutoFillSchemaDataViewInsert]
(	  @fkProfile decimal(18, 0)
	, @fkAutoFillSchemaDataView decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinProfileAutoFillSchemaDataView decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinProfileAutoFillSchemaDataView
(	  fkProfile
	, fkAutoFillSchemaDataView
)
VALUES 
(	  @fkProfile
	, @fkAutoFillSchemaDataView

)

SET @pkJoinProfileAutoFillSchemaDataView = SCOPE_IDENTITY()
