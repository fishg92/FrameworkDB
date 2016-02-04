-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in JoinProfileAutoFillDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileAutoFillDataViewUpdate]
(	  @pkJoinProfileAutoFillDataView decimal(18, 0)
	, @fkProfile decimal(18, 0) = NULL
	, @fkAutoFillDataView decimal(18, 0) = NULL

, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15))
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


UPDATE	JoinProfileAutoFillDataView
SET	fkProfile = ISNULL(@fkProfile, fkProfile),
	fkAutoFillDataView = ISNULL(@fkAutoFillDataView, fkAutoFillDataView)
WHERE 	pkJoinProfileAutoFillDataView = @pkJoinProfileAutoFillDataView
