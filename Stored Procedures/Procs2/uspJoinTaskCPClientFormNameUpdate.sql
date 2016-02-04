----------------------------------------------------------------------------
-- Update a single record in JoinTaskCPClientFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskCPClientFormNameUpdate]
(	  @pkJoinTaskCPClientFormName decimal(18, 0)
	, @fkJoinTaskCPClient decimal(18, 0) = NULL
	, @fkFormName decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinTaskCPClientFormName
SET	fkJoinTaskCPClient = ISNULL(@fkJoinTaskCPClient, fkJoinTaskCPClient),
	fkFormName = ISNULL(@fkFormName, fkFormName)
WHERE 	pkJoinTaskCPClientFormName = @pkJoinTaskCPClientFormName
