----------------------------------------------------------------------------
-- Update a single record in CPCaseWorkerPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseWorkerPhoneUpdate]
(	  @pkCPCaseWorkerPhone decimal(18, 0)
	, @fkCPRefPhoneType decimal(18, 0) = NULL
	, @Number varchar(10) = NULL
	, @Extension varchar(10) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPCaseWorkerPhone
SET	fkCPRefPhoneType = ISNULL(@fkCPRefPhoneType, fkCPRefPhoneType),
	Number = ISNULL(@Number, Number),
	Extension = ISNULL(@Extension, Extension)
WHERE 	pkCPCaseWorkerPhone = @pkCPCaseWorkerPhone
