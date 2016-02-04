-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinProfileAutoFillDataView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinProfileAutoFillDataViewInsert]
(	  @fkProfile decimal(18, 0)
	, @fkAutoFillDataView decimal(18, 0)
	, @pkJoinProfileAutoFillDataView decimal(18, 0) = NULL OUTPUT 

, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormRendition decimal(10, 0) = NULL OUTPUT 
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine


INSERT JoinProfileAutoFillDataView
(	  fkProfile
	, fkAutoFillDataView
)
VALUES 
(	  @fkProfile
	, @fkAutoFillDataView

)

SET @pkJoinProfileAutoFillDataView = SCOPE_IDENTITY()
