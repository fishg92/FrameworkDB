----------------------------------------------------------------------------
-- Insert a single record into CPCaseActivity
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPCaseActivityInsert]
(	  @fkCPCaseActivityType decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @Description varchar(MAX) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @EffectiveCreateDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPCaseActivity decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPCaseActivity
(	  fkCPCaseActivityType
	, fkCPClientCase
	, Description
	, fkCPClient
	, EffectiveCreateDate
	,CreateUser
	,CreateDate
)
VALUES 
(	  @fkCPCaseActivityType
	, @fkCPClientCase
	, @Description
	, @fkCPClient
	, @EffectiveCreateDate
	,@LUPUser
	,getdate()

)

SET @pkCPCaseActivity = SCOPE_IDENTITY()